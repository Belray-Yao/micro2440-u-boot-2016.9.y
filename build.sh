#!/bin/sh

set -e

export CROSS_COMPILE=arm-none-linux-gnueabi-

DEFAULT_PRODUCT_NAME="micro2440"

PRODUCT_NAME=

show_usage()
{
cat <<USAGE
  Usage:
      $0 <-p [product_name]> <option1> <option2>        ;build all for <product_name>
  Example:
      $0 -p micro2440;
      $0 clean
USAGE
}

MAKE_OPTS=

args="$@"

while true
do
    if [ "x$1" != "x" ];then
        case "$1" in
        "-p")
            shift
            if [ "x$1" = "x" ];then
                echo "Error, please input product name!"
                exit
            fi
            PRODUCT_NAME="$1"
            shift;;
        *)
            MAKE_OPTS="$MAKE_OPTS $1"
            shift;;
        esac
    else
        break
    fi
done
echo "#############################################################"
if [ "x$PRODUCT_NAME" = "x" ];then
    echo "## Building 'micro2440' u-boot, enabled by default."
    PRODUCT_NAME="$DEFAULT_PRODUCT_NAME"
else
    echo "## Building '$PRODUCT_NAME' u-boot."
fi
echo
if [ "$MAKE_OPTS" ];then
    echo "## OPTIONS: $MAKE_OPTS"
fi
echo "#############################################################"
make ${PRODUCT_NAME}_defconfig && make ${MAKE_OPTS}

rm -rf /media/sf_D_DRIVE/arm/*.bin

cp *.bin /media/sf_D_DRIVE/arm/
