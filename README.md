# gpg-vault v0.5.0

Easy-to-use Bash script for symmetric encryption and decryption of files or folders using GPG, with enhanced dependency management and improved zip-before-encrypt usability.

## What's New in v0.5.0

- Automatically checks for the presence of the `zip` utility before zip operations.
- If missing, prompts the user to install `zip` automatically, supporting common package managers (apt-get, yum, brew).
- Provides fallback manual installation instructions if automatic installation isn’t possible.
- Uses quiet mode to reduce clutter when creating zip archives.
- Improves script robustness and user experience relating to the zip dependency.

## Features

- Symmetric encryption/decryption of files and folders using GPG and gpgtar.
- Optional zip-before-encrypt with `-z` flag to compress targets first, now with automatic zip installation check.
- Interactive prompts to manage existing zip archives (overwrite, skip, rename).
- Safe cleanup of originals after successful encryption.
- Friendly command-line interface with clear usage and error messaging.

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

This is version **0.5.0**, the initial simple implementation.

## Author

👤 **Souvik Mitra**

- Github: [@magician79](https://github.com/magician79)

## License
Copyright © 2025 [Souvik Mitra](https://github.com/magician79).<br />
This project is licensed under the MIT License - see the [License File](LICENSE) for details.

---
