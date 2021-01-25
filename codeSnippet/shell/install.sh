#!/bin/sh

backup_date=$(date "+%Y%m%d_%H_%M_%S")
contos=`awk -F= '/^NAME/{print $2}' /etc/os-release | grep CentOS -c`
ubuntu=`awk -F= '/^NAME/{print $2}' /etc/os-release | grep Ubuntu -c`

if [ $contos -gt 0 ]; then
	username=apache
elif [ $ubuntu -gt 0 ]; then
	username=www-data
else 
	echo "-------------------------------------------------------"
	echo "install abort: unknown system, please install manunlly."
	echo "-------------------------------------------------------"
	exit 1
fi

if [ "$1" = "-h" ]; then
	echo "-------------------------------------------------------"
	echo "usage: sudo ./install.sh [-f]"
	echo "Options:"
	echo "	-d not backup old version."	
	echo "-------------------------------------------------------"
	exit 1
fi

check_user()
{
	#判断用户是否存在passwd中
	i=`cat /etc/passwd | cut -f1 -d':' | grep -w $username -c`
	if [ $i -le 0 ]; then
		return 0
	else
	#显示用户存在
		return 1
	fi
}

check_user $username

if [ $? -eq 0 ]; then
	echo "----------------------------------------------------------"
	echo "install abort: User $username is not exist, please create user:"
	echo "	useradd $username"
	echo "----------------------------------------------------------"
	exit 1
else

	if [ ! -d "mts_web" ]; then
		echo "-------------------------------------------------------"
		echo "No mts_web package,Please ask the author for help."
		echo "-------------------------------------------------------"
		exit 1
	fi

	if [ ! -d "/var/www/html_backup/" ]; then
		mkdir /var/www/html_backup
	else
		if [ -d "/var/www/html_backup/html_backup_${backup_date}/" ]; then
			timestamp=$(date "+%s")
			rm -rf /var/www/html_backup/html_backup_${backup_date}_${timestamp}.tar.bz2
			tar -jcvf /var/www/html_backup/html_backup_${backup_date}_${timestamp}.tar.bz2 /var/www/html_backup_${backup_date}
		fi
	fi

	mv /var/www/html /var/www/html_backup/html_backup_${backup_date}
	# vbox_web 主程序
	cp -r vbox_web/ /var/www/html 
	# 配置文件
	cp info.ini /var/www/html/Public/hzww_private
	# mts模块
	cp -r mts_web/ /var/www/html/MTS
		
	chown -R $username:$username /var/www/html
	if [[ $1 == "-d" ]]; then
		rm -rf /var/www/html_backup/html_backup_${backup_date}
		echo "deleted backup"
	fi
	echo "-------------------------------------------------------"
	echo "install finished."
	echo "-------------------------------------------------------"
fi

exit 0
