#!/bin/bash
#
#shadow_recon version
version="1.0.1"

path_to_dirsearch="" # here your path to dirsearch tool 
path_to_assetfinder=""# here your path to assetfinder
# import library
source ./scan.lib

#get my help function
help_function() {
    shadow_theme
    echo -e """ \e[34m
     be sure you run setup.sh as root! before use the tool
      
     Usage: ShadowRecon [-h|--help] [-m MODE] [-i] domain1 [domain2 ...]
    
     Options:
       -h, --help      Display this help message and exit
       -m MODE, --mode MODE  Set the scan mode (n-o, d-o, c-o)
       -i, --interactive  Interactive mode (prompt for domains)
    
     Modes:
       n-o    Nmap scan only
       d-o    Dirsearch scan only
       s-e    subdomain enum only
       *   Nmap, Dirsearch, and Crt.sh scans
   
     Examples:
       ShadowRecon -m <mode> example.com www.example.com
       ShadowRecon -m n-o -i for interactive mode
 \e[0m"""
}


# build arguments
while getopts "m:ih" OPTION; do
case $OPTION in

h|--help)
help_function
exit 0
;;

m)
MODE=$OPTARG
;;

i)
INTERACTIVE=true
;;
esac
done


#scan_domain function
scan_domain(){
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY
case $MODE in
n-o)

shadow_theme
nmap_scan
;;
d-o)

shadow_theme
dirsearch_scan
;;
s-e)

shadow_theme
crt_scan
assetfinder_scan
;;
*)

shadow_theme
nmap_scan
crt_scan
assetfinder_scan
dirsearch_scan
;;
esac
}

#report_domain function
report_domain(){
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "Generating recon report for $DOMAIN..."
TODAY=$(date)
echo "This scan was created on $TODAY" > $DIRECTORY/report

if [ -f $DIRECTORY/nmap ];then
echo "Results for Nmap:" >> $DIRECTORY/report
grep -E "^\s*\S+\s+\S+\s+\S+\s*$" $DIRECTORY/nmap >> $DIRECTORY/report
fi

if [ -f $DIRECTORY/dirsearch ];then
echo "Results for Dirsearch:" >> $DIRECTORY/report
cat $DIRECTORY/dirsearch >> $DIRECTORY/report
fi

if [ -f "$DIRECTORY/crt" ];then
#crt parsing ^_^
echo "Results for crt.sh and assetfinder  :" >> $DIRECTORY/report
jq -r ".[] | .name_value" $DIRECTORY/crt > $DIRECTORY/temp_crt.txt
	
fi

if [ -f "$DIRECTORY/assetfinder" ];then
#assetfinder_scan *_*
sort $DIRECTORY/assetfinder > $DIRECTORY/temp_sub.txt
sort $DIRECTORY/temp_crt.txt >> $DIRECTORY/temp_sub.txt
sort $DIRECTORY/temp_sub.txt | uniq >> $DIRECTORY/report 
rm -rf $DIRECTORY/temp_sub.txt
rm -rf $DIRECTORY/temp_crt.txt
fi

}

#building our interactive mode
if [ $INTERACTIVE ];then 
shadow_theme
INPUT="BLANK"

while [ $INPUT != "quit" ];do 
echo "Please enter a domain ->"

read INPUT

if [ $INPUT != "quit" ];then 
scan_domain $INPUT
report_domain $INPUT
fi
done

else

for i in "${@:$OPTIND:$#}";do

scan_domain $i
report_domain $i

done
fi

