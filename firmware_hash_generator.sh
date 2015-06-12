#!/bin/sh

echo "#ifndef firmware_hash_h" >vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
echo "#define firmware_hash_h" >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
echo "/*This is an autogenerated file at build time for  default*/" >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
echo "//file name $1 , cnss_locale $2" >> vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
echo "#ifdef FEATURE_SECURE_FIRMWARE" >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
if test  $2
then
BASE_BDWLAN30_DIR=vendor/qcom/nonhlos/cnss_proc/wlan/fw/target/halphy/ftm/host/systemtools/tools/eepromUtil/qc6174
bdwlanpath=$BASE_BDWLAN30_DIR/bdwlan30_$2.bin
else
varfile=`grep -A1 bdwlan30.bin $1`
pathend=`echo $varfile | grep  -Po '(?<=(file_path>)).*(?=</file_path>)'`
bdwlanpath=vendor/qcom/nonhlos/$pathend/bdwlan30.bin
fi

a=`sha256sum vendor/qcom/nonhlos/cnss_proc/wlan/fw/target/.output/AR6320/hw.3/bin/qwlan30.bin |sed 's/ .*//'|sed "s/[a-fA-F0-9][a-fA-F0-9]/0x&, /g" | sed "s/^/\{/"|sed "s/$/\},/"` && b=`sha256sum vendor/qcom/nonhlos/cnss_proc/wlan/fw/target/.output/AR6320/hw.3/bin/otp30.bin |sed 's/ .*//'|sed "s/[a-fA-F0-9][a-fA-F0-9]/0x&, /g" | sed "s/^/\{/"|sed "s/$/\},/"` && c=`sha256sum $bdwlanpath |sed 's/ .*//'|sed "s/[a-fA-F0-9][a-fA-F0-9]/0x&, /g" | sed "s/^/\{/"|sed "s/$/\},/"` && d=`sha256sum vendor/qcom/nonhlos/cnss_proc/wlan/fw/target/.output/AR6320/hw.3/bin/utf30.bin |sed 's/ .*//'|sed "s/[a-fA-F0-9][a-fA-F0-9]/0x&, /g" | sed "s/^/\{/"|sed "s/$/\},/"` && echo "static struct hash_fw fw_hash = {$a $b $c $d };" >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h

echo "#else \n static struct hash_fw fw_hash; \n  #endif " >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
echo "#endif" >>vendor/qcom/opensource/wlan/qcacld-2.0/firmware_hash.h
