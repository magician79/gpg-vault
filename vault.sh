#!/bin/bash

################################################################################
# Decrypt                                                                      #
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
# Encrypt                                                                      #
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
# Encrypt after creating zip file                                              #
################################################################################
EncryptZip() {
    local TARGET="$1"
    local ZIPNAME="${TARGET}.zip"
    if [ -e "$ZIPNAME" ]; then
        echo "Warning: '$ZIPNAME' already exists."
        echo "Press Enter to [O]verwrite, S to [S]kip, R to [R]ename:"
        read -r choice
        case "$choice" in
            ""|[Oo]*) rm -f "$ZIPNAME";;
            [Ss]*) echo "Skipping zip operation."; exit 0;;
            [Rr]*) ZIPNAME="${TARGET}_$(date +%Y%m%d%H%M%S).zip";;
            *) echo "Invalid choice. Exiting."; exit 1;;
        esac
    fi
    echo "Zipping '$TARGET' to '$ZIPNAME'..."
    zip -r "$ZIPNAME" "$TARGET"
    echo "Encrypting zipped file '$ZIPNAME' using gpg..."
    gpg --symmetric -o "${ZIPNAME}.gpg" "$ZIPNAME" && rm -rf "$TARGET" "$ZIPNAME"
    echo "File or folder '$TARGET' zipped and encrypted to '${ZIPNAME}.gpg'."
}

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "This is a tool to encrypt/decrypt files with gpg"
   echo
   echo "Syntax: vault [-o <file>] | [-l <file|folder> [-z]] | [-h]"
   echo "options:"
   echo "o     Opens the safe i.e. decrypyts the file provide"
   echo "l     Locks the safe i.e. encrypts the file provided"
   echo "z		 Zip the file or folder before encryption (use with -l)"
   echo "h     Print this Help."
   echo
}

if [[ $# -eq 0 ]]; then
    # display Help
    Help
    exit;
fi

while getopts "o:l:zh" option; do
    case $option in
        o) # decrypt
            FNAME=$OPTARG
            Decrypt $FNAME
            exit;;
        l) # encrypt
            FNAME=$OPTARG
            ENCRYPT_MODE="normal"
            ;;
        z) # zip before encrypt (sets mode)
            ENCRYPT_MODE="zip"
            ;;
        h) Help; exit;;
        \?) echo "Error: Invalid option"; exit;;
    esac
done

if [[ $ENCRYPT_MODE == "zip" ]]; then
    EncryptZip $FNAME
else
    Encrypt $FNAME
fi
