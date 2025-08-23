#!/bin/bash

################################################################################
# Decrypt                                                                      #
################################################################################
Decrypt() {
    if [[ "$1" == *.tar.gpg ]]; then
        echo "Decrypting folder '$1' using gpgtar..."
        gpgtar --decrypt --directory . "$1"
        echo "Folder decrypted from '$1' to '${1%.tar.gpg}'."
    elif [[ "$1" == *.gpg ]]; then
        echo "Decrypting file '$1' using gpg..."
        gpg --decrypt "$1" > "${1%.gpg}"
        echo "File decrypted from '$1' to '${1%.gpg}'."
    else
        echo "Error: '$1' does not appear to be an encrypted file or folder."
        exit 1
    fi
}

################################################################################
# Encrypt                                                                      #
################################################################################
Encrypt() {
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
    # Check if zip is installed
    if ! command -v zip &> /dev/null; then
        echo "The 'zip' utility is not installed."
        read -p "Do you want to install it now? [Y/n]: " answer
        answer=${answer:-Y}
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            # Detect platform and install
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y zip
            elif command -v yum &> /dev/null; then
                sudo yum install -y zip
            elif command -v brew &> /dev/null; then
                brew install zip
            else
                echo "Could not detect package manager. Please install 'zip' manually."
			       echo "For example:"
        			 echo "  sudo apt-get install zip       # Debian/Ubuntu"
        			 echo "  sudo yum install zip           # RedHat/CentOS"
        			 echo "  brew install zip               # macOS"
                exit 1
            fi

            # Re-check if zip installed successfully
            if ! command -v zip &> /dev/null; then
                echo "Installation failed. Please install 'zip' manually."
                exit 1
            fi
        else
            echo "Cannot proceed without 'zip' when using the -z (zip) option. Exiting."
            exit 1
        fi
    fi

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
    zip -rq "$ZIPNAME" "$TARGET"
    if [ $? -ne 0 ]; then
        echo "Zip operation failed."; exit 1
    fi

    echo "Encrypting zipped file '$ZIPNAME' using gpg..."
    gpg --symmetric -o "${ZIPNAME}.gpg" "$ZIPNAME"
    if [ $? -eq 0 ]; then
        rm -rf "$TARGET" "$ZIPNAME"
        echo "File or folder '$TARGET' zipped and encrypted to '${ZIPNAME}.gpg'."
    else
        echo "Encryption failed."; exit 1
    fi
}

################################################################################
# Help                                                                         #
################################################################################
Help() {
    echo "This is a tool to encrypt/decrypt files with gpg"
    echo
    echo "Syntax: vault [-o <file>] | [-l <file|folder> [-z]] | [-h]"
    echo "options:"
    echo "o Opens the safe i.e. decrypts the file provided"
    echo "l Locks the safe i.e. encrypts the file or folder provided"
    echo "z Zip the file or folder before encryption (use with -l)"
    echo "h Print this Help."
    echo
}

################################################################################

# Main script logic

if [[ $# -eq 0 ]]; then
    Help
    exit
fi

ENCRYPT_MODE="normal"

while getopts "o:l:zh" option; do
    case $option in
        o) # decrypt
            FNAME="$OPTARG"
            Decrypt "$FNAME"
            exit
            ;;
        l) # encrypt
            FNAME="$OPTARG"
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
    EncryptZip "$FNAME"
else
    Encrypt "$FNAME"
fi
