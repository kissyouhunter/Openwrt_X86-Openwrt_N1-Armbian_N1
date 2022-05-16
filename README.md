# Openwrt_X86-Openwrt_N1-Armbian_N1

* 所有固件都标注了核心版本

* 插件列表
![](https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/raw/main/lists.png)

___

## Openwrt_X86:

* IP: 192.168.2.3 ID: root Password: password

* adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

* adguardhome ID: root Password: password

* x86固件不带docker,请用一键脚本自行安装。

* （一键脚本： bash <(curl -s -S -L https://git.io/JMl6C) 或者 curl -Lo ./kiss.sh https://git.io/JMl6C && bash kiss.sh）

* 下载跳转[github](https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/tag/openwrt_x86)
___

## Openwrt_N1:

* IP: 192.168.2.4 ID: root Password: password

* adguardhome已内置好DNS和广告过滤，下载好核心后开启即可。

* adguardhome ID: root Password: password wifi password: password

* N1固件不带docker,请用一键脚本自行安装。

* （一键脚本： bash <(curl -s -S -L https://git.io/JMl6C) 或者 curl -Lo ./kiss.sh https://git.io/JMl6C && bash kiss.sh）

### 升级方式一：

* 一键升级命令:（最新的固件已支持在U盘运行的openwrt）

* 如已刷入本固件，ssh连接n1或ttyd输入update即可。

* 命令一：bash <(curl -Lso- https://tt.kisssik.ga/d/aliyun/files/update-N1.sh))

* 命令二：bash <(curl -s -S -L https://git.io/update-N1) 

* 根据命令操作就可以，强烈推荐，保证/mnt/mmcblk2p4/或/mnt/sda4分区剩余空间1G以上，查看命令df -h。

### 升级方式二：

* 由译内核的不同，如升级emmc里的固件请用releases里的update-amlogic-openwrt.sh文件

* 将update-amlogic-openwrt.sh和img文件上传至/mnt/mmcblk2p4分区

* ssh连接n1或ttyd输入如下命令：

* cd /mnt/mmcblk2p4/ && chmod 755 update-N1-openwrt.sh

* ./update-N1-openwrt.sh 文件名.img  #img文字名请自行输入

* 跑码过程中都有中文提示，请根据提示操作即可。

* 系统重启后使用命令 rm -rf /mnt/mmcblk2p4/文件名img 删除  #img文字名请自行输入

[注：三分区版本的N1只能重新写入固件到emmc，无法直接升级固件](#注：三分区版本的N1只能重新写入固件到emmc，无法直接升级固件)

* 下载跳转[github](https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/tag/openwrt_n1) [国内](http://tt.kisssik.ga)
___

## Armbian_N1:

* ID: root Password: 1234

* 第一次登陆强制修改密码

* U盘使用请扩展roofts分区（工具https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/blob/main/DiskGenius/DiskGenius.5.1.1.x86.Pro.7z ）

* 常用命令armbian-config（配置ip、cpu等配置）; armbian-install（安装到emmc）; armbian-docker （一键安装docker）；armbian-update（更新内核）；armbian-container（一键安装常用docker容器）。

* 下载跳转[github](https://github.com/kissyouhunter/Openwrt_X86-Openwrt_N1-Armbian_N1/releases/tag/Armbian) [国内](http://tt.kisssik.ga)
