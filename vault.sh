#!/bin/bash

################################################################################
# Decrypt                                                                         #
################################################################################
Decrypt()
{
   # Decrypt folder or file
	 if [[ "$1" == *.tar.gpg ]]; then
	  echo "Decrypting folder '${1}' using gpgtar..."
	  gpgtar --decrypt --directory . "$1"
	  echo "Folder decrypted from '${1}' to '${1%.tar.gpg}'."
	 elif [[ "$1" == *.gpg ]]; then
	  echo "Decrypting file '${1}' using gpg..."
	  gpg --decrypt "$1" > "${1%.gpg}"
	  echo "File decrypted from '${1}' to '${1%.gpg}'."
	 else
	  echo "Error: '$1' does not appear to be an encrypted file or folder."
	  exit 1
	 fi
}

################################################################################
# Encrypt                                                                         #
################################################################################
Encrypt()
{
	# Encrypt folder or file
	 if [ -d "$1" ]; then
	  echo "Encrypting folder '$1' using gpgtar..."
	  gpgtar --symmetric -o "${1}.tar.gpg" "$1" && rm -rf "$1"
	  echo "Folder '$1' encrypted to '${1}.tar.gpg'."
	 elif [ -f "$1" ]; then
	  echo "Encrypting file '$1' using gpg..."
	  gpg --symmetric -o "${1}.gpg" "$1" && rm -rf "$1"
	  echo "File '$1' encrypted to '${1}.gpg'."
	 else
	  echo "Error: '$1' is neither a file nor a directory."
	  exit 1
	 fi
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
