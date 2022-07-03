#!/bin/bash
#author kissyouhunter

url_kernel="https://cloud.kisslove.eu.org/d/aliyun/kernel"
url_op="https://cloud.kisslove.eu.org/d/aliyun/N1"
url_file="https://cloud.kisslove.eu.org/d/aliyun/files"
update_file="update-N1-openwrt.sh"
op_version="R22.6.16"

## openwrt版本
op_version_54="5.4.201"
op_version_510="5.10.126"
op_version_515="5.15.50"
op_version_518="5.18.7"

## kernel版本
kervel_version_54="5.4.203"
kervel_version_510="5.10.128"
kervel_version_515="5.15.52"
kervel_version_518="5.18.9"

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

if [ -a "/etc/flippy-openwrt-release" ]; then
  TIME g "flippy-openwrt-release文件存在"
  sleep 2
elif [ -a "/etc/openwrt-release" ]; then
  cp /etc/openwrt-release /etc/flippy-openwrt-release -v
  TIME g "flippy-openwrt-release生成成功"
  sleep 2
fi

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
TIME g "============================================"

TIME b "(1) 更新固件至EMMC"
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
TIME b "(1) 更新至内核 ${op_version_54}  版本 到EMMC"
TIME y "(2) 更新至内核 ${op_version_510} 版本 到EMMC"
TIME z "(3) 更新至内核 ${op_version_515}  版本 到EMMC"
TIME m "(4) 更新至内核 ${op_version_518}   版本 到EMMC"
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
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_510} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_510}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_518} 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_518}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_518}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 49895) 
  TIME g " >>>>>>>>>>>更新至内核 5.17.15 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k5.17.15-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k5.17.15-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
TIME b "(1) 更新至内核 ${op_version_54}  版本 到U盘"
TIME y "(2) 更新至内核 ${op_version_510} 版本 到U盘"
TIME z "(3) 更新至内核 ${op_version_515}  版本 到U盘"
TIME m "(4) 更新至内核 ${op_version_518}   版本 到U盘"
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
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
  TIME g " >>>>>>>>>>>更新至内核 ${op_version_518} 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k${op_version_518}-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k${op_version_518}-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 ${update_file}
  bash ${update_file} $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4695656) 
  TIME g " >>>>>>>>>>>更新至内核 5.17.15 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  Firmware=openwrt_s905d_n1_${op_version}_k5.17.15-kissyouhunter.img.gz
  img=openwrt_s905d_n1_${op_version}_k5.17.15-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO ${url_op}/$Firmware
  wget ${url_file}/${update_file}
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
u_boot_url=https://cloud.kisslove.eu.org/d/aliyun/kernel/files/u-boot.ext

download_n1_kernel() {
    TIME w "开始下载内核文件。"
    mkdir -p ${download_path}
    #cd ${download_path}
    curl -Lo ${download_path}/${boot_file} ${url_kernel}/${kernel_number}/${boot_file}
    curl -Lo ${download_path}/${modules_file} ${url_kernel}/${kernel_number}/${modules_file}
    curl -Lo ${download_path}/${dtb_file} ${url_kernel}/${kernel_number}/${dtb_file}
    sync
    TIME g "内核文件下载完毕。"
}

check_kernel() {
    TIME w "开始检查文件。"
    cd ${download_path}

    # Determine custom kernel filename
    kernel_boot="$(ls boot-*.tar.gz | head -n 1)"
    kernel_name="${kernel_boot/boot-/}" && kernel_name="${kernel_name/.tar.gz/}"
    KERNEL_VERSION="$(echo ${kernel_name} | grep -oE '^[1-9].[0-9]{1,3}.[0-9]+')"

    # Check the sha256sums file
    sha256sums_file="sha256sums"
    sha256sums_check="1"
    [[ -s "${sha256sums_file}" && -n "$(cat ${sha256sums_file})" ]] || sha256sums_check="0"
    [[ -n "$(which sha256sum)" ]] || sha256sums_check="0"
    [[ "${sha256sums_check}" -eq "1" ]]

    # Loop check file
    i="1"
    kernel_list=("boot" "dtb-amlogic" "modules")
    for kernel_file in ${kernel_list[*]}; do
        # Set check filename
        tmp_file="${kernel_file}-${kernel_name}.tar.gz"
        # Check if file exists
        [[ -s "${tmp_file}" ]] || TIME r "文件[ ${kernel_file} ]不完整。"
        # Check if the file sha256sum is correct
        if [[ "${sha256sums_check}" -eq "1" ]]; then
            tmp_sha256sum="$(sha256sum "${tmp_file}" | awk '{print $1}')"
            tmp_checkcode="$(cat ${sha256sums_file} | grep ${tmp_file} | awk '{print $1}')"
            [[ "${tmp_sha256sum}" == "${tmp_checkcode}" ]] || TIME r "${tmp_file}: sha256sum 不 OJBK"
            TIME r "(${i}/3) [ ${tmp_file} ] 文件 sha256sum OJBK."
        fi
        let i++
    done
    TIME g "下载的文件都OJBK"
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
    curl -LO ${u_boot_url}
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
    echo "KERNEL_VERSION='${kernel_name}'" >>/etc/flippy-openwrt-release
    sed -i '/K510/d' /etc/flippy-openwrt-release
    echo "K510='0'" >>/etc/flippy-openwrt-release
    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
    sync
    TIME g "内核显示内容更新完毕。"
}

# 5.10以上内核
update_release_file510() {
    TIME w "开始更新内核显示内容。"
    sed -i '/KERNEL_VERSION/d' /etc/flippy-openwrt-release
    echo "KERNEL_VERSION='${kernel_name}'" >>/etc/flippy-openwrt-release
    sed -i '/K510/d' /etc/flippy-openwrt-release
    echo "K510='1'" >>/etc/flippy-openwrt-release
    sed -i "s/ Kernel.*/ Kernel: ${kernel_name}/g" /etc/banner
    sync
    TIME g "内核显示内容更新完毕。"
}

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g "============================================"

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-4]****|"
TIME g "---------------------------------------"
TIME b "(1) 更新至内核 ${kervel_version_54}"
TIME y "(2) 更新至内核 ${kervel_version_510}"
TIME z "(3) 更新至内核 ${kervel_version_515}"
TIME m "(4) 更新至内核 ${kervel_version_518}"
TIME l "(0) 返回上级菜单"

read -p "Please enter your choice[0-4]: " input
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
4)
TIME g " >>>>>>>>>>>更新至内核 ${kervel_version_518}"

kernel_number=${kervel_version_518}
kernel_name=${kervel_version_518}-kissyouhunter
boot_file=boot-${kervel_version_518}-kissyouhunter.tar.gz
modules_file=modules-${kervel_version_518}-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-${kervel_version_518}-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 ${kervel_version_518} 更新完毕，备重启中。"
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