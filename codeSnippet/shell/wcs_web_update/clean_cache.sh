#!/bin/sh

if [ "$1" = "-h" ]; then
	echo "-------------------------------------------------------"
	echo "usage: sudo ./install.sh [-f]"
	echo "Options:"
	echo "	-d not backup old version."	
	echo "-------------------------------------------------------"
	exit 1
fi

if [ ! -d "Application/Runtime"]; then
    if [ ! -f "Application/Runtime/*.php"]; then
        rm -f "Application/Runtime/*.php"
    fi
    if [ ! -d "Application/Runtime/Temp"]; then
        rm -f "Application/Runtime/Temp"
    fi
    if [ ! -d "Application/Runtime/Cache"]; then
        rm -f "Application/Runtime/Cache"
    fi
else
    echo "-------------------------------------------------------"
	echo "  No Runtime Cache"	
	echo "-------------------------------------------------------"
	exit 1
fi