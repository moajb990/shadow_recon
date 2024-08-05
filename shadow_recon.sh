#!/usr/bin/bash
source scan_lib


# help usage -h / --help

help_function() {
    shadow_theme
    echo "be sure you run setup.sh as root! before use the tool"
    echo  
    echo "Usage: ShadowRecon [-h|--help] [-m MODE] [-i] domain1 [domain2 ...]"
    echo
    echo "Options:"
    echo "  -h, --help      Display this help message and exit"
    echo "  -m MODE, --mode MODE  Set the scan mode (n-o, d-o, c-o)"
    echo "  -i, --interactive  Interactive mode (prompt for domains)"
    echo
    echo "Modes:"
    echo "  n-o    Nmap scan only"
    echo "  d-o    Dirsearch scan only"
    echo "  c-o    Crt.sh scan only"
    echo "  *   Nmap, Dirsearch, and Crt.sh scans"
    echo
    echo "Examples:"
    echo "  ShadowRecon example.com www.example.com"
    echo "  ShadowRecon -m d-o -i"
    echo
}

while getopts "m:ih" OPTION;do

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

DOMAIN=$1

######################
# scan types
scan_domain() 
{
  DIRECTORY=${DOMAIN}_recon
  echo "creating directory $DIRECTORY."
  mkdir -p $DIRECTORY

  if [ "$MODE" = "d-o" ]; then
    dirsearch_scan
  elif [ "$MODE" = "c-o" ]; then
    crt_scan
  elif [ "$MODE" = "n-o" ]; then
    nmap_scan
  else
    nmap_scan
    crt_scan
    dirsearch_scan
  fi

  report_domain $DOMAIN $DIRECTORY
}

#######################
# report file generator
report_domain()
{
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "creating directory $DIRECTORY."
mkdir "$DIRECTORY"
TODAY=$(date)
echo "this scan was created on $TODAY" > $DIRECTORY/report

if [ -f $DIRECTORY/nmap ];then 
echo "Result fro nmap:" >> $DIRECTORY/report
grep -E "^\s*\S+\s+\S+\s+\S+\s*$" $DIRECTORY/nmap >> $DIRECTORY/report
fi

if [ -f $DIRECTORY/dirsearch ];then
echo "the result of dirsearch scan:" >> $DIRECTORY/report
cat $DIRECTORY/dirsearch >> $DIRECTORY/report
fi

if [ -f $DIRECTORY/crt ];then
    echo "the result of crt.sh" >> $DIRECTORY/report
    jq -r '.[].name_value' $DIRECTORY/crt >> $DIRECTORY/report
fi
}
######################
# interactive mode 
if [ $INTERACTIVE ] ;then

           
INPUT="BLANK"
while [ $INPUT != "quit" ];do
  echo "please enter a domain >" && read INPUT
  if [ $INPUT != "quit" ];then
    DOMAIN=$INPUT
    scan_domain
    report_domain $DOMAIN $DIRECTORY
  fi
done
else
  for i in "$@";do
    DOMAIN=$i
    scan_domain
    report_domain $DOMAIN $DIRECTORY
  done
fi
