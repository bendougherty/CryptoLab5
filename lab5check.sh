#!/bin/bash

#display help information
help()
{
echo
echo "This script should be in the same directory as your students' nameca.crt and namecompany.crt files. This script takes one argument which should be a text file that contains the names of your students (the name they are using for naming their files) one per line. The script will iterate through the student names in the file verifying the certificates; it will display name: Verified OK if it works or name: Not Verified if it does not work."
echo
echo "Syntax: lab2check.sh [-h] namefile"
echo
echo "options:"
echo
echo "h      Print this help"
echo
}

#Get options
while getopts ":h" option; do
   case $option in
      h) #Display help
         help
         exit;;
     \?) #incorrect option
         echo "Error: Invalid option"
	 exit;;
   esac
done

if [[ $# -eq 0 ]]
then
   echo "You must provide a file with a list of student names. See -h for more information."
   exit 1
fi

filename=$1
while read line; do
fileone="${line}ca.crt"
filetwo="${line}company.crt"
echo -n "${line}: " >> classLab4Results.txt
openssl verify -CAfile $fileone $filetwo >> classLab4Results.txt
echo >> classLab4Results.txt
done < $filename
