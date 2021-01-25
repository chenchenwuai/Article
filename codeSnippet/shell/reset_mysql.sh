#!/bin/sh

line=`sed -n '/\[mysqld_safe\]/=' /etc/my.cnf`

sed -i "${line}-1s/.*/skip-grant-table/" /etc/my.cnf