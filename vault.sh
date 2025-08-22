#!/bin/bash

################################################################################
# Decrypt                                                                         #
################################################################################
Decrypt()
{
   # Decrypt file
   echo "decrypting file $1"
   gpg $1
   echo RELOADAGENT | gpg-connect-agent
   echo
}

################################################################################
# Encrypt                                                                         #
################################################################################
Encrypt()
{
   # Encrypt file
   echo "encrypting file $1"
   gpg --symmetric $1 && rm -rf $1
   echo
}

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "This is a tool to encrypt/decrypt files with gpg"
   echo
   echo "Syntax: vault [-o|l] <file> | [-h]"
   echo "options:"
   echo "o     Opens the safe i.e. decrypyts the file provide"
   echo "l     Locks the safe i.e. encrypts the file provided"
   echo "h     Print this Help."
   echo
}

if [[ $# -eq 0 ]]; then
    # display Help
    Help
    exit;
fi

while getopts "o:l:h" option; do
   case $option in
      o) # decrypt file
         FNAME=$OPTARG
         Decrypt $FNAME
         exit;;
      l) # encrypt file
         FNAME=$OPTARG
         Encrypt $FNAME
         exit;;
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

