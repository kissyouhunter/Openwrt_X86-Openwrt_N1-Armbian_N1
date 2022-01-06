#!/bin/bash
#author kissyouhunter

declare flag=0
clear
while [ "$flag" -eq 0 ]
do
echo "============================================"
echo "       欢迎使用N1——openwrt更新脚本"
echo " 使用本脚本前，请确认当前设备已存在四个分区"
echo "           查看命令为 lsblk "
echo "          默认ip：192.168.2.4 "
echo "    默认账号：root 默认密码：password "
echo "============================================"
cat << EOF
----------------------------------------
(1) 更新固件至EMMC!
(2) 更新固件至U盘!
(0) 怂了，不更新了！
EOF
read -p "Please enter your choice[0-2]: " input
case $input in
#更新固件至EMMC
1)
clear
while [ "$flag" -eq 0 ]
do
cat << EOF
----------------------------------------
|****Please Enter Your Choice:[0-3]****|
----------------------------------------
(1) 更新至内核 5.4.170 版本 到EMMC
(2) 更新至内核 5.10.90 版本 到EMMC
(3) 更新至内核 5.15.13 版本 到EMMC
(0) 返回上级菜单
EOF
 read -p "Please enter your choice[0-3]: " input1
 case $input1 in 
 1)
  echo -e " >>>>>>>>>>>更新至内核 5.4.170 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.4.170-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R2.1.1_k5.4.170-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)  
  echo -e " >>>>>>>>>>>更新至内核 5.10.90 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.10.90-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.10.90-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  echo -e " >>>>>>>>>>>更新至内核 5.15.13 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 49) 
  echo -e " >>>>>>>>>>>更新至内核 5.15.13 版本 到EMMC开始"
  cd /mnt/mmcblk2p4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;  
 0) 
 clear 
 break
 ;;
 *) echo "----------------------------------"
    echo "|          Warning!!!            |"
    echo "|       请输入正确的选项!         |"
    echo "----------------------------------"
 for i in `seq -w 3 -1 1`
   do
     echo -ne "$i";
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
cat << EOF
----------------------------------------
|****Please Enter Your Choice:[0-3]****|
----------------------------------------
(1) 更新至内核 5.4.170 版本 到U盘
(2) 更新至内核 5.10.90 版本 到U盘
(3) 更新至内核 5.15.13 版本 到U盘
(0) 返回上级菜单
EOF
 read -p "Please enter your Choice[0-3]: " input2
 case $input2 in 
 1)
  echo -e " >>>>>>>>>>>更新至内核 5.4.170 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.4.170-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.4.170-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 2)
  echo -e " >>>>>>>>>>>更新至内核 5.10.90 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.10.90-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.10.90-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 3) 
  echo -e " >>>>>>>>>>>更新至内核 5.15.13 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 4596) 
  echo -e " >>>>>>>>>>>更新至内核 5.15.13 版本 到U盘开始"
  cd /mnt/sda4
  rm -rf update-*.sh openwrt_*
  url=https://mirror.ghproxy.com/https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/download/openwrt_n1
  Firmware=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img.gz
  img=openwrt_s905d_n1_R22.1.1_k5.15.13-kissyouhunter.img
  echo "====下载固件中(需科学上网,否则无法更新)===="
  curl -LO $url/$Firmware
  wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/main/update-N1-openwrt.sh
  echo "=============下载完成,解压中=============="
  gzip -d *.img.gz && rm -f *.img.gz
  echo "===========解压完成,开始升级固件==========="
  chmod 755 update-N1-openwrt.sh
  bash update-N1-openwrt.sh $img
  echo "=============删除残留升级文件============="
  rm -rf update-*.sh openwrt_*
  exit 0
  ;;
 0) 
 clear 
 break
 ;;
 *) echo "----------------------------------"
    echo "|          Warning!!!            |"
    echo "|       请输入正确的选项!         |"
    echo "----------------------------------"
 for i in `seq -w 3 -1 1`
   do
     echo -ne "$i";
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
*)  echo "----------------------------------"
 echo "|          Warning!!!            |"
 echo "|       请输入正确的选项!         |"
 echo "----------------------------------"
 for i in `seq -w 3 -1 1`
   do
     echo -ne "$i";
     sleep 1;
   done
 clear
;;
esac
done
