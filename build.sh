#!/bin/sh

set -e

export CROSS_COMPILE=arm-none-linux-gnueabi-

DEFAULT_PRODUCT_NAME="micro2440"

PRODUCT_NAME=

show_usage()
{
cat <<USAGE
  Usage:
      $0 <product_name>		;build all for <product_name>
  Example:
      $0 micro2440;
      $0
USAGE
}

if [ $# -gt 1 ];then
	echo "ERROR!"
	show_usage
elif [ $# -gt 0 ];then
	echo "## Start build u-boot for '$1'! ##"
	PRODUCT_NAME="$1"
else
	echo "## Start build u-boot for 'micro2440', enabled by default! ##"
	PRODUCT_NAME=${DEFAULT_PRODUCT_NAME}
fi


make ${PRODUCT_NAME}_defconfig

make

rm -rf /media/sf_D_DRIVE/arm/*.bin

cp *.bin /media/sf_D_DRIVE/arm/
