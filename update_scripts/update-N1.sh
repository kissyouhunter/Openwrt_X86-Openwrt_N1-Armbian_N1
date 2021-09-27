#/bin/bash


#bash <(curl -s -S -L https://git.io/Phicomm-n1_update)
TIME() {
[[ -z "$1" ]] && {
	echo -ne " "
} || {
     case $1 in
	r) export Color="\e[31;1m";;
	g) export Color="\e[32;1m";;
	b) export Color="\e[34;1m";;
	y) export Color="\e[33;0m";;
	z) export Color="\e[35;1m";;
	l) export Color="\e[36;1m";;
      esac
	[[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
		echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
	 }
      }
}

	while :; do
	TIME g "---------------------------------------------------"
	TIME g "[1] 更新至 内核 5.14.8 版本"
	echo
	TIME g "[2] 更新至 内核 5.13.19 版本"
	echo
	TIME g "[3] 更新至 内核 5.10.69 版本"
	echo
	TIME g "[4] 更新至 内核 5.4.149 版本"
	echo
	TIME g "[0] 不知道选啥就按0看看会有啥惊喜没?"
	TIME g "---------------------------------------------------"
	read -p " 请输入您的选择 然后 敲回车确认： " CHOOSE
	case $CHOOSE in
	1)
	echo
	TIME y "[1] 更新至 内核 5.14.8 版本"
        cd /mnt/mmcblk2p4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.149_5.10.69_5.14.8
        Firmware=openwrt_s905d_n1_R21.9.18_k5.14.8-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.9.18_k5.14.8-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-amlogic-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-amlogic-openwrt.sh
        bash update-amlogic-openwrt.sh $img
	break
	;;
	2)
	echo
	TIME y "[2] 更新至 内核 5.13.19 版本"
        cd /mnt/mmcblk2p4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.10.67_5.13.19_5.14.6
        Firmware=openwrt_s905d_n1_R21.9.18_k5.13.19-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.9.18_k5.13.19-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-amlogic-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-amlogic-openwrt.sh
        bash update-amlogic-openwrt.sh $img
	break
	;;
	3)
	echo
	TIME y "[3] 更新至 内核 5.10.69 版本"
        cd /mnt/mmcblk2p4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.149_5.10.69_5.14.8
        Firmware=openwrt_s905d_n1_R21.9.18_k5.10.69-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.9.18_k5.10.69-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-amlogic-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-amlogic-openwrt.sh
        bash update-amlogic-openwrt.sh $img
	break
	;;
	4)
	echo
	TIME y "[4] 更新至 内核 5.4.148 版本"
        cd /mnt/mmcblk2p4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.149_5.10.69_5.14.8
        Firmware=openwrt_s905d_n1_R21.9.18_k5.4.149-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.9.18_k5.4.149-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-amlogic-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-amlogic-openwrt.sh
        bash update-amlogic-openwrt.sh $img
	break
	;;
	0)
	echo
	TIME r "您选择了 [0] 想啥呢！！！好好工作！！!"
	exit 0
	break
    	;;
    	*)
	echo
	TIME r "大哥：服了！！!"
	;;
	esac
	done

echo
