# gpg-vault v0.4.0

Easy-to-use Bash script for symmetric encryption and decryption of files or folders using GPG, with improved zip-before-encrypt functionality and robust error handling.

## What's New in v0.4.0

- Added error detection for zip compression and GPG encryption commands.
- Ensures original files/folders are deleted only after successful encryption.
- Improved user feedback on failures.
- Refined command-line option parsing and script flow.

## Features

- Symmetric encryption/decryption of files and folders using GPG and gpgtar.
- Optional zip-before-encrypt operation with `-z` flag to compress targets first.
- Handles existing zip archive name conflicts with user options.
- Safe removal of originals after successful encryption.
- Clear, user-friendly CLI interface and feedback.

## Usage

### Decrypt a file
```sh
vault.sh -o <encrypted-file-or-folder>
```

### Encrypt a file
```sh
vault.sh -l <file-or-folder>
```

### Encrypt (zip first) a file or folder
```sh
vault.sh -l <file-or-folder> -z
```

### Display help
```sh
vault.sh -h
```

**Examples:**
- Encrypt a directory with zip-then-encrypt:
```sh
./vault.sh -l myfolder -z
```
- Decrypt a zipped+encrypted archive:
```sh
./vault.sh -o myfolder.zip.gpg
```

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/magician79/gpg-vault.git
   ```

2. Make the script executable:  
   ```sh
   chmod +x vault.sh
   ```

3. Run using:  
   ```sh
   ./vault.sh [options]
   ```

## Version

This is version **0.4.0**, the initial simple implementation.

## Author

👤 **Souvik Mitra**

- Github: [@magician79](https://github.com/magician79)

## License
Copyright © 2025 [Souvik Mitra](https://github.com/magician79).<br />
This project is licensed under the MIT License - see the [License File](LICENSE) for details.

---
