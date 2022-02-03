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
	w) export Color="\e[29;1m";;
      esac
	[[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
		echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
	 }
      }
}

TIME g "============================================"
TIME g "       欢迎使用N1——openwrt更新脚本"
TIME g " 使用本脚本前，请确认当前设备已存在四个分区"
TIME g "           查看命令为 lsblk "
TIME g "          默认ip：192.168.2.4 "
TIME g "    默认账号：root 默认密码：password "
TIME g "============================================"

TIME b "(1) 更新固件至EMMC!"
TIME y "(2) 更新固件至U盘!"
TIME l "(0) 怂了，不更新了！"

read -p "Please enter your choice[0-2]: " input
case $input in
#更新固件至EMMC
1)
clear
while [ "$flag" -eq 0 ]
do

TIME g "----------------------------------------"
TIME g "|****Please Enter Your Choice:[0-3]****|"
TIME g "---------------------------------------"
TIME b "(1) 更新至内核 5.4.176 版本 到EMMC"
TIME y "(2) 更新至内核 5.10.96 版本 到EMMC"
TIME z "(3) 更新至内核 5.15.19 版本 到EMMC"
TIME w "(4) 更新至内核 5.16.5  版本 到EMMC"
TIME l "(0) 返回上级菜单"

 read -p "Please enter your choice[0-4]: " input1
 case $input1 in 
 1)
  TIME g " >>>>>>>>>>>更新至内核 5.4.176 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.4.176-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.4.176-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)  
  TIME g " >>>>>>>>>>>更新至内核 5.10.96 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.10.96-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.10.96-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  TIME g " >>>>>>>>>>>更新至内核 5.15.19 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.19-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.19-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4) 
  TIME g " >>>>>>>>>>>更新至内核 5.16.5 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.16.5-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.16.5-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
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
 for i in `seq -w 3 -1 1`
   do
     TIME r "$i";
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
TIME g "|****Please Enter Your Choice:[0-3]****|"
TIME g "----------------------------------------"
TIME b "(1) 更新至内核 5.4.176 版本 到U盘"
TIME y "(2) 更新至内核 5.10.96 版本 到U盘"
TIME z "(3) 更新至内核 5.15.19 版本 到U盘"
TIME w "(4) 更新至内核 5.16.5  版本 到U盘"
TIME l "(0) 返回上级菜单"

 read -p "Please enter your Choice[0-4]: " input2
 case $input2 in 
 1)
  TIME g " >>>>>>>>>>>更新至内核 5.4.176 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.4.176-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.4.176-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)
  TIME g " >>>>>>>>>>>更新至内核 5.10.96 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.10.96-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.10.96-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  TIME g " >>>>>>>>>>>更新至内核 5.15.19 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.19-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.19-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  TIME g "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4) 
  TIME g " >>>>>>>>>>>更新至内核 5.16.5 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.16.5-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.16.5-kissyouhunter.img
  TIME g "==========下载固件中==========="
  TIME r "====需科学上网,否则无法更新===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  TIME g "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  TIME g "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
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
 for i in `seq -w 3 -1 1`
   do
     TIME r "$i";
     sleep 1;
   done
 clear
 ;;
 esac
 done
;;
0)
clear
exit 0
;;
*)  TIME r "----------------------------------"
 TIME r "|          Warning!!!            |"
 TIME r "|       请输入正确的选项!        |"
 TIME r "----------------------------------"
 for i in `seq -w 3 -1 1`
   do
     TIME r "$i";
     sleep 1;
   done
 clear
;;
esac
done
