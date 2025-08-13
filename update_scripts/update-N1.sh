#!/bin/bash
#author kissyouhunter

url_kernel="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/kernel_stable"
url_op="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/n1_openwrt"
url_op_docker="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/n1_openwrt_with_docker"
url_file="https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/refs/heads/main"
update_file="update-N1-openwrt.sh"
op_version="R25.06.22"

## 集中版本管理
kernel_versions=(6.1.142 6.1.147 6.6.99 6.6.101)

TIME() {
[[ -z "$1" ]] && {
    echo -ne " "
} || {
     case $1 in
    r) export Color="\e[31;1m";;
    g) export Color="\e[32;1m";;
    b) export Color="\e[34;1m";;
    y) export Color="\e[33;1m";;
    z) export Color="\e[35;1m";;
    l) export Color="\e[36;1m";;
    m) export Color="\e[37;1m";;
    w) export Color="\e[29;1m";;
      esac
    [[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
        echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
     }
      }
}

# ============== 实用检测函数 ==============

# 增强版的空间检查
enhanced_volume_check() {
    local target_location=$1
    TIME w "正在检查 ${target_location} 存储空间..."
    
    if [ "$target_location" == "EMMC" ]; then
        local mount_point="/mnt/mmcblk2p4"
    else
        local mount_point="/mnt/sda4"  
    fi
    
    # 检查可用空间
    local available=$(df -m "$mount_point" 2>/dev/null | tail -1 | awk '{print $4}')
    if [[ -z "$available" ]]; then
        TIME r "错误：无法获取 ${target_location} 可用空间"
        return 1
    fi
    
    TIME l "当前 ${target_location} 可用空间：${available}MB"
    
    if [[ $available -lt 1024 ]]; then
        TIME r "错误：${target_location} 可用空间不足（需要至少1GB，当前${available}MB）"
        return 1
    fi
    
    TIME g "${target_location} 存储空间检查通过"
    return 0
}

# 增强版文件下载检查
enhanced_download_check() {
    local file_path=$1
    local file_url=$2
    local file_name=$(basename "$file_path")
    
    TIME w "检查文件：$file_name"
    
    # 检查文件是否存在
    if [ ! -f "$file_path" ]; then
        TIME r "文件 $file_name 不存在"
        return 1
    fi
    
    # 检查文件大小
    local local_size=$(wc -c < "$file_path" 2>/dev/null)
    if [[ -z "$local_size" || "$local_size" -eq 0 ]]; then
        TIME r "文件 $file_name 为空或无法读取"
        return 1
    fi
    
    # 获取在线文件大小并比较
    local online_size=$(wget --spider -S "$file_url" 2>&1 | grep -i content-length | tail -1 | grep -o '[0-9]\+')
    if [[ -n "$online_size" && "$local_size" -eq "$online_size" ]]; then
        TIME g "文件 $file_name 完整（大小：${local_size} 字节）"
    elif [[ -n "$online_size" ]]; then
        TIME r "文件 $file_name 大小不匹配（本地：$local_size，在线：$online_size）"
        return 1
    else
        TIME y "文件 $file_name 无法验证大小，但存在（大小：${local_size} 字节）"
    fi
    
    # 检查文件权限
    if [ ! -r "$file_path" ]; then
        TIME r "文件 $file_name 不可读"
        return 1
    fi
    
    return 0
}

# 增强版下载函数
enhanced_download() {
    local url=$1
    local output_path=$2
    local file_name=$(basename "$output_path")
    
    TIME w "开始下载：$file_name"
    
    # 下载文件，增加重试和超时设置
    if wget --timeout=30 --tries=3 --retry-connrefused -N -O "$output_path" "$url"; then
        TIME g "下载成功：$file_name"
        return 0
    else
        TIME r "下载失败：$file_name"
        # 删除可能的不完整文件
        [ -f "$output_path" ] && rm -f "$output_path"
        return 1
    fi
}

# ============== 原有函数 ==============

volume_check() {
    volume=$(df -m | grep /dev/mmcblk2p4 | grep -v docker | awk '{print $4}')
    if [[ $volume -ge 1024 ]]; then
    echo
    else
    TIME r "p4分区为${volume}m，小于1G。删除垃圾文件后再运行更新命令"
    exit 0
    fi
}

if [ -a "/etc/flippy-openwrt-release" ]; then
  TIME g "flippy-openwrt-release文件存在"
  sleep 2
elif [ -a "/etc/openwrt-release" ]; then
  cp /etc/openwrt-release /etc/flippy-openwrt-release -v
  TIME g "flippy-openwrt-release生成成功"
  sleep 2
fi

select_docker_version() {
    clear
    TIME g "=========================================="
    TIME g "        请选择固件版本类型"
    TIME g "=========================================="
    TIME w "(1) 标准版（无Docker）"
    TIME y "(2) Docker版（包含Docker）"
    TIME l "(0) 返回上级菜单"
    
    read -p "Please enter your choice[0-2]: " docker_choice
    case $docker_choice in
    1)
        selected_url=$url_op
        TIME g "已选择：标准版（无Docker）"
        ;;
    2)
        selected_url=$url_op_docker
        TIME g "已选择：Docker版（包含Docker）"
        ;;
    0)
        return 1
        ;;
    *)
        TIME r "请输入正确的选项!"
        sleep 2
        select_docker_version
        ;;
    esac
    return 0
}

update_firmware() {
    local target_location=$1
    local version=$2
    local version_name=$3
    
    # 增强版空间检查，空间不足时自动退出
    if ! enhanced_volume_check "$target_location"; then
        return 1
    fi
    
    if ! select_docker_version; then
        return
    fi
    
    TIME g " >>>>>>>>>>>更新至内核 ${version} 版本 到${target_location}开始"
    
    if [ "$target_location" == "EMMC" ]; then
        cd /mnt/mmcblk2p4
    else
        cd /mnt/sda4
    fi
    
    rm -rf update-*.sh openwrt_*
    Firmware=openwrt_s905d_n1_${op_version}_k${version}-kissyouhunter.img.gz
    img=openwrt_s905d_n1_${op_version}_k${version}-kissyouhunter.img
    
    TIME g "==========下载固件中==========="
    TIME r "====需科学上网,否则无法更新===="
    
    # 使用增强版下载
    if ! enhanced_download "${selected_url}/$Firmware" "$Firmware"; then
        TIME r "固件下载失败"
        return 1
    fi
    
    if ! enhanced_download "${url_file}/${update_file}" "$update_file"; then
        TIME r "更新脚本下载失败"
        return 1
    fi
    
    TIME g "=============下载完成,解压中=============="
    if ! gzip -d *.img.gz; then
        TIME r "解压失败"
        return 1
    fi
    rm -f *.img.gz
    
    # 检查解压后的文件
    if [ ! -f "$img" ]; then
        TIME r "解压后的镜像文件不存在"
        return 1
    fi
    
    TIME g "===========解压完成,开始升级固件==========="
    chmod 755 ${update_file}
    
    # 自动执行更新（去掉确认提示）
    bash ${update_file} $img
    TIME g "=============删除残留升级文件============="
    rm -rf update-*.sh openwrt_*
    exit 0
}

choose_firmware_version() {
    local target_location=$1
    TIME g "----------------------------------------"
    TIME g "|****Please Enter Your Choice****|"
    TIME g "---------------------------------------"
    
    PS3="请选择要更新的内核版本（输入序号）："
    select ver in "${kernel_versions[@]}" "返回上级菜单"; do
        case $ver in
            "返回上级菜单") 
                break 
                ;;
            "") 
                TIME r "无效选择，请重新输入。" 
                ;;
            *)
                update_firmware "$target_location" "$ver" "内核${ver}"
                break
                ;;
        esac
    done
}

openwrt() {
declare flag=0
clear
while [ "$flag" -eq 0 ]
do

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g " 使用本脚本前，请确认当前设备已存在四个分区"
TIME g "           查看命令为 lsblk "
TIME g "          默认ip：192.168.2.4 "
TIME g "    默认账号：root 默认密码：password "
TIME r "最新版本可能无法与上个版本兼容，升级前请做好备份 "
TIME g "============================================"

TIME w "(1) 更新固件至EMMC"
TIME y "(2) 更新固件至U盘"
TIME l "(0) 返回上级菜单"

read -p "Please enter your choice[0-2]: " input
case $input in
1)
    clear
    choose_firmware_version "EMMC"
    ;;
2)
    clear
    choose_firmware_version "U盘"
    ;;
0)
    clear
    break
    ;;
*)  
    TIME r "----------------------------------"
    TIME r "|          Warning!!!            |"
    TIME r "|       请输入正确的选项!        |"
    TIME r "----------------------------------"
    sleep 1
    clear
    ;;
esac
done
}

kernel() {
declare flag=0
clear
while [ "$flag" -eq 0 ]
do

download_path=/tmp/upload
u_boot_url="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/kernel_stable/u-boot.ext"

download_n1_kernel() {
    TIME w "开始下载内核文件。"
    mkdir -p ${download_path}
    
    # 使用增强版下载
    if ! enhanced_download "${url_kernel}/${kernel_number}/${boot_file}" "${download_path}/${boot_file}"; then
        exit 1
    fi
    if ! enhanced_download "${url_kernel}/${kernel_number}/${modules_file}" "${download_path}/${modules_file}"; then
        exit 1
    fi
    if ! enhanced_download "${url_kernel}/${kernel_number}/${dtb_file}" "${download_path}/${dtb_file}"; then
        exit 1
    fi
    
    sync
    TIME g "内核文件下载完毕。"
}

check_kernel() {
    TIME w "开始检查文件。"
    cd ${download_path}

    # 使用增强版文件检查
    if ! enhanced_download_check "${download_path}/${boot_file}" "${url_kernel}/${kernel_number}/${boot_file}"; then
        exit 1
    fi
    if ! enhanced_download_check "${download_path}/${modules_file}" "${url_kernel}/${kernel_number}/${modules_file}"; then
        exit 1
    fi
    if ! enhanced_download_check "${download_path}/${dtb_file}" "${url_kernel}/${kernel_number}/${dtb_file}"; then
        exit 1
    fi
    
    sync && echo ""
    TIME g "所有文件检查完成"
}

update_boot() {
    TIME w "开始更新boot。"
    rm -f /boot/config-* /boot/initrd.img-* /boot/System.map-* /boot/uInitrd-* /boot/vmlinuz-* && sync
    rm -f /boot/uInitrd /boot/zImage && sync
    tar -xf ${download_path}/${boot_file} -C /boot && sync
    cd /boot && cp -f uInitrd-${kernel_name} uInitrd && cp -f vmlinuz-${kernel_name} zImage && sync
    if [ -f "/boot/config-${kernel_name}" ] && [ -f "/boot/System.map-${kernel_name}" ] && [ -f "/boot/uInitrd-${kernel_name}" ] && [ -f "/boot/vmlinuz-${kernel_name}" ] && [ -f "/boot/uInitrd" ] && [ -f "/boot/zImage" ]; then
        TIME g "boot OJBK。"
    else
        TIME r "boot 不OJBK。"
        exit 1
    fi
}

update_dtb() {
    TIME w "开始更新dtb。"
    cd /boot/dtb/amlogic/ && rm -f * && sync
    tar -xf ${download_path}/${dtb_file} -C /boot/dtb/amlogic/ && sync
    if [ -f "/boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb" ]; then
        TIME g "dtb OJBK。"
    else
        TIME r "dtb 不OJBK。"
        exit 1
    fi
}

update_modules() {
    TIME w "开始更新modules。"
    rm -rf /lib/modules/* && sync
    tar -xf ${download_path}/${modules_file} -C /lib/modules/ && sync
    cd /lib/modules/${kernel_name}
    rm -f *.ko
    find ./ -type f -name '*.ko' -exec ln -s {} ./ \;
    sync && sleep 3
    x=$(ls *.ko -l | grep "^l" | wc -l)
    if [ "${x}" -eq "0" ]; then
        TIME r "*.ko 文件错误。"
        exit 1
    fi
    TIME g "modules OJBK。"
}

update_uboot54() {
    TIME w "开始更新uboot。"
    rm -f /boot/u-boot.ext
    if [ -f "/boot/u-boot.ext" ]; then
        TIME r "uboot 不OJBK。"
        exit 1
    else
        TIME g "uboot OJBK。"
    fi
}

update_uboot510() {
    TIME w "开始更新uboot"
    cd ${download_path}
    
    # 使用增强版下载
    if ! enhanced_download "${u_boot_url}" "${download_path}/u-boot.ext"; then
        TIME r "u-boot下载失败"
        exit 1
    fi
    
    rm -f /boot/u-boot.ext
    cp -f ${download_path}/u-boot.ext /boot/u-boot.ext && sync
    if [ -f "/boot/u-boot.ext" ]; then
        TIME g "uboot OJBK。"
    else
        TIME r "uboot 不OJBK。"
        exit 1
    fi
}

update_release_file54() {
    TIME w "开始更新内核显示内容。"
    sed -i '/KERNEL_VERSION/d' /etc/flippy-openwrt-release
    echo "KERNEL_VERSION=${kernel_name}" >>/etc/flippy-openwrt-release
    sed -i '/K510/d' /etc/flippy-openwrt-release
    echo "K510=0" >>/etc/flippy-openwrt-release
    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
    sync
    TIME g "内核显示内容更新完毕。"
}

update_release_file510() {
    TIME w "开始更新内核显示内容。"
    sed -i '/KERNEL_VERSION/d' /etc/flippy-openwrt-release
    echo "KERNEL_VERSION=${kernel_name}" >>/etc/flippy-openwrt-release
    sed -i '/K510/d' /etc/flippy-openwrt-release
    echo "K510=1" >>/etc/flippy-openwrt-release
    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
    sync
    TIME g "内核显示内容更新完毕。"
}

update_kernel() {
    local version=$1
    local is_54_kernel=$2
    
    TIME g " >>>>>>>>>>>更新至内核 ${version}"

    kernel_number=${version}
    kernel_name=${version}-kissyouhunter
    boot_file=boot-${version}-kissyouhunter.tar.gz
    modules_file=modules-${version}-kissyouhunter.tar.gz
    dtb_file=dtb-amlogic-${version}-kissyouhunter.tar.gz

    download_n1_kernel
    check_kernel
    update_boot
    update_dtb
    update_modules
    
    if [ "$is_54_kernel" == "true" ]; then
        update_uboot54
        update_release_file54
    else
        update_uboot510
        update_release_file510
    fi
    
    TIME g ">>>>>>>>>>>内核 ${version} 更新完毕，准备重启中。"
    
    # 自动重启（去掉确认提示）
    sleep 3
    reboot
    exit 0
}

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g "============================================"

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice****|"
TIME g "---------------------------------------"

PS3="请选择要更新的内核版本（输入序号）："
select ver in "${kernel_versions[@]}" "返回上级菜单"; do
    case $ver in
        "返回上级菜单") 
            break 
            ;;
        "") 
            TIME r "无效选择，请重新输入。" 
            ;;
        *)
            update_kernel "$ver" "false"
            break
            ;;
    esac
done

done
}

menu(){
while :; do
echo
TIME g "---- N1固件 在线更新菜单 ----"
echo
TIME g "[1] 更新 N1固件"
echo
TIME g "[2] 更新 N1内核"
echo
TIME g "[0] 退出更新!"
TIME g "-------------------------------"
read -p " 请输入 序号 敲回车确认： " CHOOSE
case $CHOOSE in
1)
  clear
  openwrt
  ;;
2)
  clear
  kernel
  ;;
0)
exit 0
break
;;
*)
echo
TIME r "请输入正确的序号!"
;;
esac
done
}
menu
