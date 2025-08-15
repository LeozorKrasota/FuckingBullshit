#!/bin/sh

#move to script directory so all relative paths work
echo "Start installing Freeswitch"
cd "$(dirname "$0")"

#includes
. ./config.sh
. ./environment.sh

if [ .$switch_source = .true ]; then
    echo "Fucking shit number one"
	if [ ."$switch_branch" = "master" ]; then
		echo "Start script switch/source-master.sh"
		switch/source-master.sh
	else
		echo "Start script switch/source-release.sh"
		switch/source-release.sh
	fi

	#add sounds and music files
	switch/source-sounds.sh

	#copy the switch conf files to /etc/freeswitch
	switch/conf-copy.sh

	#set the file permissions
	#switch/source-permissions.sh
	switch/package-permissions.sh

	#systemd service
	#switch/source-systemd.sh
	switch/package-systemd.sh
fi

if [ .$switch_package = .true ]; then
    echo "Fucking shit number two"
	if [ ."$switch_branch" = "master" ]; then
		if [ .$switch_package_all = .true ]; then
			echo "Start script switch/package-master-all.sh"
			switch/package-master-all.sh
		else
			echo "Start script switch/package-master.sh"
			switch/package-master.sh
		fi
	else
		if [ .$switch_package_all = .true ]; then
			echo "Start script switch/package-all.sh"
			switch/package-all.sh
		else
			echo "Start script switch/package-release.sh"
			switch/package-release.sh
		fi
	fi

	#copy the switch conf files to /etc/freeswitch
	switch/conf-copy.sh

	#set the file permissions
	switch/package-permissions.sh

	#systemd service
	switch/package-systemd.sh
fi
