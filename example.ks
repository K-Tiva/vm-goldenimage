#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use text install
text
# Run the Setup Agent on first boot
firstboot --disable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=jp --xlayouts='jp'
# System language
lang ja_JP.UTF-8
# SELinux configuration
selinux --disabled

# Network information
network  --bootproto=static --device=ens192 --ip=192.168.1.101 --nameserver=192.168.1.1 --netmask=255.255.255.0 --noipv6 --activate
network  --hostname=localhost.localdomain

# Root password
rootpw --iscrypted $6$lDHiJIyOZIZwWpza$1qhUqdF7QgfXj.FtaX85qHel9F6erOLSEWwYE8rJomejBoLLGZWVyN4RrdjUqKxOIM62OEsQvgpqcGqLGF72o0
# System services
services --enabled="chronyd"
# System timezone
timezone Asia/Tokyo --isUtc
# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --all --initlabel --drives=sda
zerombr
# Disk partitioning information
#autopart
part pv.128 --fstype="lvmpv" --ondisk=sda --size=1 --grow
part /boot --fstype="xfs" --ondisk=sda --size=1024 --label=boot
volgroup centos --pesize=4096 pv.128
logvol swap --fstype="swap" --size=1024 --name=swap --vgname=centos
logvol / --fstype="xfs" --grow --maxsize=51200 --size=1024 --grow --name=root --vgname=centos --label="root"

reboot --eject

%packages
@^minimal
@core
chrony

%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end
