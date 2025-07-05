#!/bin/bash
#author kissyouhunter

url_kernel="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/kernel_stable"
url_op="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/n1_openwrt"
url_op_docker="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/n1_openwrt_with_docker"
url_file="https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/refs/heads/main"
update_file="update-N1-openwrt.sh"
op_version="R25.06.22"

## 版本定义（固件和内核使用相同版本）
version_54="5.4.295"
version_510="5.10.239"
version_515="5.15.186"
version_61="6.1.142"
version_66="6.6.95"

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

# Docker版本选择函数
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
        docker_suffix=""
        TIME g "已选择：标准版（无Docker）"
        ;;
    2)
        selected_url=$url_op_docker
        docker_suffix="_with_docker"
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

# 固件更新函数
update_firmware() {
    local target_location=$1
    local version=$2
    local version_name=$3
    
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
    Firmware=openwrt_s905d_n1_${op_version}_k${version}-kissyouhunter${docker_suffix}.img.gz
    img=openwrt_s905d_n1_${op_version}_k${version}-kissyouhunter${docker_suffix}.img
    
    TIME g "==========下载固件中==========="
    TIME r "====需科学上网,否则无法更新===="
    wget -N ${selected_url}/$Firmware
    wget -N ${url_file}/${update_file}
    TIME g "=============下载完成,解压中=============="
    gzip -d *.img.gz && rm -f *.img.gz
    TIME g "===========解压完成,开始升级固件==========="
    chmod 755 ${update_file}
    bash ${update_file} $img
    TIME g "=============删除残留升级文件============="
    rm -rf update-*.sh openwrt_*
    exit 0
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
    while [ "$flag" -eq 0 ]
    do
        TIME g "----------------------------------------"
        TIME g "|****Please Enter Your Choice:[0-5]****|"
        TIME g "---------------------------------------"
        TIME w "(1) 更新至内核 ${version_54}  版本 到EMMC"
        TIME y "(2) 更新至内核 ${version_510} 版本 到EMMC"
        TIME w "(3) 更新至内核 ${version_515} 版本 到EMMC"
        TIME y "(4) 更新至内核 ${version_61}  版本 到EMMC"
        TIME w "(5) 更新至内核 ${version_66}   版本 到EMMC"
        TIME l "(0) 返回上级菜单"

        read -p "Please enter your choice[0-5]: " input1
        case $input1 in 
        1) update_firmware "EMMC" $version_54 "5.4内核" ;;
        2) update_firmware "EMMC" $version_510 "5.10内核" ;;
        3) update_firmware "EMMC" $version_515 "5.15内核" ;;
        4) update_firmware "EMMC" $version_61 "6.1内核" ;;
        5) update_firmware "EMMC" $version_66 "6.6内核" ;;
        0) clear; break ;;
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
    ;;
2)
    clear
    while [ "$flag" -eq 0 ]
    do
        TIME g "----------------------------------------"
        TIME g "|****Please Enter Your Choice:[0-5]****|"
        TIME g "----------------------------------------"
        TIME w "(1) 更新至内核 ${version_54}  版本 到U盘"
        TIME y "(2) 更新至内核 ${version_510} 版本 到U盘"
        TIME w "(3) 更新至内核 ${version_515} 版本 到U盘"
        TIME y "(4) 更新至内核 ${version_61}  版本 到U盘"
        TIME w "(5) 更新至内核 ${version_66}   版本 到U盘"
        TIME l "(0) 返回上级菜单"

        read -p "Please enter your Choice[0-5]: " input2
        case $input2 in 
        1) update_firmware "U盘" $version_54 "5.4内核" ;;
        2) update_firmware "U盘" $version_510 "5.10内核" ;;
        3) update_firmware "U盘" $version_515 "5.15内核" ;;
        4) update_firmware "U盘" $version_61 "6.1内核" ;;
        5) update_firmware "U盘" $version_66 "6.6内核" ;;
        0) clear; break ;;
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
u_boot_url="https://cloud.kisslove.eu.org/d/onedrive/OPENWRT/N1_OP/kernel/u-boot.ext"

download_n1_kernel() {
    TIME w "开始下载内核文件。"
    mkdir -p ${download_path}
    wget -N -O ${download_path}/${boot_file} ${url_kernel}/${kernel_number}/${boot_file}
    wget -N -O ${download_path}/${modules_file} ${url_kernel}/${kernel_number}/${modules_file}
    wget -N -O ${download_path}/${dtb_file} ${url_kernel}/${kernel_number}/${dtb_file}
    sync
    TIME g "内核文件下载完毕。"
}

check_kernel() {
    TIME w "开始检查文件。"
    cd ${download_path}

    # check boot file
    local_boot_file_size=$(wc -c < "${boot_file}")
    online_boot_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${boot_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    if [ "${local_boot_file_size}" == "${online_boot_file_size}" ]; then
        TIME g "文件${boot_file}完整"
    else
        TIME r "文件${boot_file}不完整"
        exit 1
    fi

    # check modules file
    local_modules_file_size=$(wc -c < "${modules_file}")
    online_modules_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${modules_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    if [ "${local_modules_file_size}" == "${online_modules_file_size}" ]; then
        TIME g "文件${modules_file}完整"
    else
        TIME r "文件${modules_file}不完整"
        exit 1
    fi

    # check dtb file
    local_dtb_file_size=$(wc -c < "${dtb_file}")
    online_dtb_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${dtb_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    if [ "${local_dtb_file_size}" == "${online_dtb_file_size}" ]; then
        TIME g "文件${dtb_file}完整"
    else
        TIME r "文件${dtb_file}不完整"
        exit 1
    fi
    sync && echo ""
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

# 5.4内核
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

# 5.10以上内核
update_uboot510() {
    TIME w "开始更新uboot"
    cd ${download_path}
    wget -N ${u_boot_url}
    rm -f /boot/u-boot.ext
    cp -f ${download_path}/u-boot.ext /boot/u-boot.ext && sync
    if [ -f "/boot/u-boot.ext" ]; then
        TIME g "uboot OJBK。"
    else
        TIME r "uboot 不OJBK。"
        exit 1
    fi
}

# 5.4内核
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

# 5.10以上内核
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

# 内核更新函数
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
    sleep 3
    reboot
    exit 0
}

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g "============================================"

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-5]****|"
TIME g "---------------------------------------"
TIME w "(1) 更新至内核 ${version_54}"
TIME y "(2) 更新至内核 ${version_510}"
TIME w "(3) 更新至内核 ${version_515}"
TIME y "(4) 更新至内核 ${version_61}"
TIME y "(5) 更新至内核 ${version_66}"
TIME l "(0) 返回上级菜单"

read -p "Please enter your choice[0-5]: " input
case $input in
1) update_kernel $version_54 "true" ;;
2) update_kernel $version_510 "false" ;;
3) update_kernel $version_515 "false" ;;
4) update_kernel $version_61 "false" ;;
5) update_kernel $version_66 "false" ;;
0) clear; break ;;
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
