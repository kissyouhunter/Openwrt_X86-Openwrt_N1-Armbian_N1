#!/bin/bash
#author kissyouhunter

url_kernel="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/kernel_stable"
url_op="https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/n1_openwrt"
url_file="https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/refs/heads/main"
update_file="update-N1-openwrt.sh"
op_version="R25.06.22"

## openwrt版本
op_version_54="5.4.294"
op_version_510="5.10.238"
op_version_515="5.15.185"
op_version_61="6.1.141"
op_version_66="6.6.94"

## kernel版本
kervel_version_54="5.4.294"
kervel_version_510="5.10.238"
kervel_version_515="5.15.185"
kervel_version_61="6.1.141"
kervel_version_66="6.6.94"

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
#volume_check
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
TIME r "最新版本可能无法可上个版本兼容，升级前请做好备份 "
TIME g "============================================"

TIME w "(1) 更新固件至EMMC"
TIME y "(2) 更新固件至U盘"
TIME l "(0) 返回上级菜单"

read -p "Please enter your choice[0-2]: " input
case $input in
#更新固件至EMMC
1)

clear
while [ "$flag" -eq 0 ]
do

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-4]****|"
TIME g "---------------------------------------"
TIME w "(1) 更新至内核 ${op_version_54}  版本 到EMMC"
TIME y "(2) 更新至内核 ${op_version_510} 版本 到EMMC"
TIME w "(3) 更新至内核 ${op_version_515} 版本 到EMMC"
TIME y "(4) 更新至内核 ${op_version_61}  版本 到EMMC"
TIME w "(5) 更新至内核 ${op_version_66}   版本 到EMMC"
TIME l "(0) 返回上级菜单"

 read -p "Please enter your choice[0-4]: " input1
 case $input1 in 
 1)
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_54} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_54}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_54}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)  
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_510} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_515} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_515}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_515}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_61} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_61}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_61}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 5) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_66} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_66}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_66}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 0) 
 clear 
 break
 ;;
 *) TIME r "----------------------------------"
    TIME r "|          Warning!!!            |"
    TIME r "|       请输入正确的选项!        |"
    TIME r "----------------------------------"
 for i in $(seq -w 1 -1 1)
   do
     #TIME r "\b\b$i";
     sleep 1;
   done
 clear
 ;;
 esac
 done
;;
#更新固件至U盘
2)
clear
while [ "$flag" -eq 0 ]
do

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-4]****|"
TIME g "----------------------------------------"
TIME w "(1) 更新至内核 ${op_version_54}  版本 到U盘"
TIME y "(2) 更新至内核 ${op_version_510} 版本 到U盘"
TIME w "(3) 更新至内核 ${op_version_515} 版本 到U盘"
TIME y "(4) 更新至内核 ${op_version_61}  版本 到U盘"
TIME w "(5) 更新至内核 ${op_version_66}   版本 到U盘"
TIME l "(0) 返回上级菜单"

 read -p "Please enter your Choice[0-4]: " input2
 case $input2 in 
 1)
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_54} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_54}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_54}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_510} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_515} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_515}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_515}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_61} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_61}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_61}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 5) 
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_66} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_66}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_66}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  wget -N ${url_op}/$Firmware
  wget -N ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 0) 
 clear 
 break
 ;;
 *) TIME r "----------------------------------"
    TIME r "|          Warning!!!            |"
    TIME r "|       请输入正确的选项!        |"
    TIME r "----------------------------------"
 for i in $(seq -w 1 -1 1)
   do
     #TIME r "\b\b$i";
     sleep 1;
   done
 clear
 ;;
 esac
 done
;;
0)
clear
break
;;
*)  TIME r "----------------------------------"
 TIME r "|          Warning!!!            |"
 TIME r "|       请输入正确的选项!        |"
 TIME r "----------------------------------"
 for i in $(seq -w 1 -1 1)
   do
     #TIME r "\b\b$i";
     sleep 1;
   done
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
    #cd ${download_path}
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
    #echo ${local_boot_file_size}
    online_boot_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${boot_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    #echo ${online_boot_file_size}
    if [ "${local_boot_file_size}" == "${online_boot_file_size}" ]; then
        TIME g "文件${boot_file}完整"
    else
        TIME r "文件${boot_file}不完整"
        exit 1
    fi

    # check modules file
    local_modules_file_size=$(wc -c < "${modules_file}")
    #echo ${local_modules_file_size}
    online_modules_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${modules_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    #echo ${online_modules_file_size}
    if [ "${local_modules_file_size}" == "${online_modules_file_size}" ]; then
        TIME g "文件${modules_file}完整"
    else
        TIME r "文件${modules_file}不完整"
        exit 1
    fi

    # check boot file
    local_dtb_file_size=$(wc -c < "${dtb_file}")
    #echo ${local_dtb_file_size}
    online_dtb_file_size=$(wget --spider -S "${url_kernel}/${kernel_number}/${dtb_file}" 2>&1 | grep -v "Content-Length: 0" | grep Content-Length | grep -o '[0-9]\+')
    #echo ${online_dtb_file_size}
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

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g "============================================"

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-5]****|"
TIME g "---------------------------------------"
TIME w "(1) 更新至内核 ${kervel_version_54}"
TIME y "(2) 更新至内核 ${kervel_version_510}"
TIME w "(3) 更新至内核 ${kervel_version_515}"
TIME y "(4) 更新至内核 ${kervel_version_61}"
TIME y "(5) 更新至内核 ${kervel_version_66}"
TIME l "(0) 返回上级菜单"

read -p "Please enter your choice[0-5]: " input
case $input in
1)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_54}"

kernel_number=${kervel_version_54}
kernel_name=${kervel_version_54}-kissyouhunter
boot_file=boot-${kervel_version_54}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_54}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_54}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot54
update_release_file54
TIME g ">>>>>>>>>>>内核 ${kervel_version_54} 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
2)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_510}"

kernel_number=${kervel_version_510}
kernel_name=${kervel_version_510}-kissyouhunter
boot_file=boot-${kervel_version_510}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_510}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_510}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 ${kervel_version_510} 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
3)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_515}"

kernel_number=${kervel_version_515}
kernel_name=${kervel_version_515}-kissyouhunter
boot_file=boot-${kervel_version_515}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_515}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_515}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 ${kervel_version_515} 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
5)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_66}"

kernel_number=${kervel_version_66}
kernel_name=${kervel_version_66}-kissyouhunter
boot_file=boot-${kervel_version_66}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_66}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_66}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 ${kervel_version_66} 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
4)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_61}"

kernel_number=${kervel_version_61}
kernel_name=${kervel_version_61}-kissyouhunter
boot_file=boot-${kervel_version_61}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_61}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_61}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 ${kervel_version_61} 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
0)
clear
break
;;
*)  TIME r "----------------------------------"
 TIME r "|          Warning!!!            |"
 TIME r "|       请输入正确的选项!        |"
 TIME r "----------------------------------"
 for i in $(seq -w 1 -1 1)
   do
     #TIME r "\b\b$i";
     sleep 1;
   done
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
