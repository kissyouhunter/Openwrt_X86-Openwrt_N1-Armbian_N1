# Openwrt_X86-Openwrt_N1-Armbian_N1

* 所有固件都标注了核心版本

___

## Openwrt_X86:

* IP: 192.168.2.3 ID: root Password: password

* adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

* adguardhome ID: root Password: password

* x86固件分为带docker和不带docker的版本，请根据需求食用。

***[注：5.10内核的ip为192.168.2.5]***(#注：5.10内核的ip为192.168.2.5)

___

## Openwrt_N1:

* IP: 192.168.2.4 ID: root Password: password

* adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

* adguardhome ID: root Password: password wifi password: password

* N1固件分为带docker和不带docker的版本，请根据需求食用。

* 由译内核的不同，如升级emmc里的固件请用releases里的update-amlogic-openwrt.sh文件

* 将update-amlogic-openwrt.sh和img文件上传至/mnt/mmcblk2p4分区

* ssh连接n1或ttyd输入如下命令：

* cd /mnt/mmcblk2p4/ && chmod 755 update-amlogic-openwrt.sh

* ./update-amlogic-openwrt.sh 文件名.img  #img文字名请自行输入

* 跑码过程中都有中文提示，请根据提示操作即可。

* 系统重启后使用命令 rm -rf /mnt/mmcblk2p4/文件名img 删除  #img文字名请自行输入

***注：三分区版本的N1只能重新写入固件到emmc，无法直接升级固件***

___

## Armbian_N1:

* ID: root Password: 1234

* 第一次登陆强制修改密码
