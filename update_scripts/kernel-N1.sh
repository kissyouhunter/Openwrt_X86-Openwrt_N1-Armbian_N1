#!/bin/bash
#author kissyouhunter

declare flag=0
clear
while [ "$flag" -eq 0 ]
do

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

download_path=/tmp/upload
u_boot_url=https://tt.kisssik.ga/d/aliyun/kernel/files/u-boot.ext
url=https://tt.kisssik.ga/d/aliyun/kernel

download_n1_kernel() {
    TIME w "开始下载内核文件。"
    mkdir -p ${download_path}
    #cd ${download_path}
    curl -Lo ${download_path}/${boot_file} ${url}/${kernel_number}/${boot_file}
    curl -Lo ${download_path}/${modules_file} ${url}/${kernel_number}/${modules_file}
    curl -Lo ${download_path}/${dtb_file} ${url}/${kernel_number}/${dtb_file}
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

if [ -a "/etc/flippy-openwrt-release" ]; then
  TIME g "flippy-openwrt-release文件存在"
  sleep 2
elif [ -a "/etc/openwrt-release" ]; then
  cp /etc/openwrt-release /etc/flippy-openwrt-release -v
  TIME g "flippy-openwrt-release生成成功"
  sleep 2
fi

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g "============================================"

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-4]****|"
TIME g "---------------------------------------"
TIME b "(1) 更新至内核 5.4.201"
TIME y "(2) 更新至内核 5.10.125"
TIME z "(3) 更新至内核 5.15.50"
TIME m "(4) 更新至内核 5.18.7"
TIME l "(0) 怂了，不更新了！"

read -p "Please enter your choice[0-4]: " input
case $input in
1)
TIME g " >>>>>>>>>>>更新至内核 5.4.201"

kernel_number=5.4.201
kernel_name=5.4.201-kissyouhunter
boot_file=boot-5.4.201-kissyouhunter.tar.gz
modules_file=modules-5.4.201-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-5.4.201-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot54
update_release_file54
TIME g ">>>>>>>>>>>内核 5.4.201 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
2)
TIME g " >>>>>>>>>>>更新至内核 5.10.125"

kernel_number=5.10.125
kernel_name=5.10.125-kissyouhunter
boot_file=boot-5.10.125-kissyouhunter.tar.gz
modules_file=modules-5.10.125-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-5.10.125-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 5.10.125 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
3)
TIME g " >>>>>>>>>>>更新至内核 5.15.50"

kernel_number=5.15.50
kernel_name=5.15.50-kissyouhunter
boot_file=boot-5.15.50-kissyouhunter.tar.gz
modules_file=modules-5.15.50-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-5.15.50-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 5.15.50 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
4)
TIME g " >>>>>>>>>>>更新至内核 5.18.7"

kernel_number=5.18.7
kernel_name=5.18.7-kissyouhunter
boot_file=boot-5.18.7-kissyouhunter.tar.gz
modules_file=modules-5.18.7-kissyouhunter.tar.gz
dtb_file=dtb-amlogic-5.18.7-kissyouhunter.tar.gz

download_n1_kernel
check_kernel
update_boot
update_dtb
update_modules
update_uboot510
update_release_file510
TIME g ">>>>>>>>>>>内核 5.18.7 更新完毕，备重启中。"
sleep 3
reboot
exit 0
;;
0)
clear
exit 0
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
