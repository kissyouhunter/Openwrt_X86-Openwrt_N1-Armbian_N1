# Openwrt_X86-Openwrt_N1-Armbian_N1

Openwrt_X86:

IP: 192.168.2.3 ID: root Password: password

adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

adguardhome ID: root Password: password


Openwrt_N1:

IP: 192.168.2.4 ID: root Password: password

adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

adguardhome ID: root Password: password

N1固件分为带docker和不带docker的版本，请根据需求食用。

由于编译内核的不同，如升级emmc里的固件请用releases里的update-amlogic-openwrt.sh文件

将update-amlogic-openwrt.sh和img文件上传至/mnt/mmcblk2p4分区

ssh连接n1或ttyd输入如下命令：

cd /mnt/mmcblk2p4/ && chmod 755 update-amlogic-openwrt.sh

./update-amlogic-openwrt.sh openwrt_**********.img  #img文字名请自行输入

*注：三分区版本的N1只能重新写入固件到emmc，无法直接升级固件*

Armbian_N1:

ID: root Password: 1234

第一次登陆强制修改密码
