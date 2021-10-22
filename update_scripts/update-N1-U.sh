#/bin/bash


#bash <(curl -s -S -L http://fx.zitcn.com/N1/Update.SH)
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
	TIME g "[1] 更新至 内核 5.14.14 版本"
	echo
	TIME g "[2] 更新至 内核 5.10.75 版本"
	echo
	TIME g "[3] 更新至 内核 5.4.155 版本"
	echo
	TIME g "[0] 更新后，设备会自动重启！"
	TIME g "---------------------------------------------------"
	read -p " 请输入您的选择 然后 敲回车确认： " CHOOSE
	case $CHOOSE in
	1)
	echo
	TIME y "[1] 更新至 内核 5.14.14 版本"
        cd /mnt/sda4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.155_5.10.75_5.14.14
        Firmware=openwrt_s905d_n1_R21.10.1_k5.14.14-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.10.1_k5.14.14-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-N1-openwrt.sh
        bash update-N1-openwrt.sh $img
	break
	;;
	2)
	echo
	TIME y "[3] 更新至 内核 5.10.75 版本"
        cd /mnt/sda4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.155_5.10.75_5.14.14
        Firmware=openwrt_s905d_n1_R21.10.1_k5.10.75-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.10.1_k5.10.75-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-N1-openwrt.sh
        bash update-N1-openwrt.sh $img
	break
	;;
	3)
	echo
	TIME y "[4] 更新至 内核 5.4.155 版本"
        cd /mnt/sda4
        rm -rf update-*.sh openwrt_*
        url=https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/5.4.155_5.10.75_5.14.14
        Firmware=openwrt_s905d_n1_R21.10.1_k5.4.155-kissyouhunter-docker.img.gz
        img=openwrt_s905d_n1_R21.10.1_k5.4.155-kissyouhunter-docker.img
	TIME g "=====================下载固件中(需科学上网,否则无法更新)======================"
        curl -LO $url/$Firmware
	wget https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
        TIME g "===============================下载完成,解压中==============================="
        gzip -d *.img.gz && rm -f *.img.gz
        TIME r "============================解压完成,开始升级固件============================"
        chmod 755 update-N1-openwrt.sh
        bash update-N1-openwrt.sh $img
	break
	;;
	0)
	echo
	TIME r "您选择了 [0] 退出升级程序，请保存好重要文件后再执行命令。"
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
