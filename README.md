# gpg-vault v0.2.0

Easy-to-use Bash script for symmetric encryption and decryption of files or folders using GPG.

## What's New in v0.2.0

- Adds support for secure encryption/decryption of entire **folders** using `gpgtar`.
- Auto-detects whether the input is a folder (`.tar.gpg`), encrypted file (`.gpg`), or unsupported type.
- Cleaner and more informative user messages.
- Improved help text and script structure.

## Features

- Symmetric encryption/decryption for both files and folders.
- Uses GPG for files and gpgtar for folder operations.
- Overwrites the original file or folder after encryption for added security.
- Command-line interface with helpful error handling.

## Usage

### Decrypt a file
```sh
vault.sh -o <encrypted-file-or-folder>
```

### Encrypt a file
```sh
vault.sh -l <file-or-folder>
```

### Display help
```sh
vault.sh -h
```

Supported formats:
- To encrypt a folder: The output will be a `.tar.gpg` encrypted archive
- To decrypt a `.tar.gpg` file: The folder will be extracted after decryption
- Regular files use `.gpg` extension when encrypted

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

This is version **0.2.0**, the initial simple implementation.

## Author

👤 **Souvik Mitra**

- Github: [@magician79](https://github.com/magician79)

## License
Copyright © 2025 [Souvik Mitra](https://github.com/magician79).<br />
This project is licensed under the MIT License - see the [License File](LICENSE) for details.

---
