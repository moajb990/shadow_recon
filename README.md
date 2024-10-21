1)first thing run setup & update & recon files as root always

chmod command:
cd shadow_recon
chmod +x *


setup:
./setup.sh

for update the tool:

1) go to /home/$user/Desktop/shadow_recon-up/
2) ./update_repo.sh
this just for first time if you want do update it another time just type (up-shr) in your terminal

this all about update and setup


usage:
-> shr -h or --help

     be sure you run setup.sh as root! before use the tool
      
     Usage: ShadowRecon [-h|--help] [-m MODE] [-i] domain1 [domain2 ...]
    
     Options:
       -h, --help      Display this help message and exit
       -m MODE, --mode MODE  Set the scan mode (n-o, d-o, c-o)
       -i, --interactive  Interactive mode (prompt for domains)
    
     Modes:
       n-o    Nmap scan only
       d-o    Dirsearch scan only
       c-o    Crt.sh scan only
       *   Nmap, Dirsearch, and Crt.sh scans
   
     Examples:
       ShadowRecon -m <mode> example.com www.example.com
       ShadowRecon -m n-o -i for interactive mode

shr -m <MODE> <TARGET1> <TARGET2/optional> <TARGET3/optional>
there is 3 MODES in version 1.0.0 
modes:
1)n-o this run  nmap scan only 
2)d-o this running the dir search tool only
3)c-o this doing the crt.sh parsing only
4)* this running evrything



there is also INTERACTIVE MODE

with -i will go to interactive mode

example:

shr -i -m <mode>
then you will see
enter domain target > example.com
or for evrything scan

shr -i
enter target domain -> example.com




       
