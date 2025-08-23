# gpg-vault v0.3.0

Easy-to-use Bash script for symmetric encryption and decryption of files or folders using GPG, now with optional zip+encrypt!

## What's New in v0.3.0

- **Zip Before Encryption:** Use `-z` option with `-l` to zip a file or folder before encrypting, producing `<name>.zip.gpg`.
- **Intelligent Overwrite Handling:** Script prompts to overwrite, skip, or rename if destination zip exists.
- **Refined Command-Line Use:** Streamlined flags for improved UX.
- **Improved Help Descriptions:** Clearer, more complete help output.

## Features

- Symmetric GPG encryption/decryption of files and folders.
- Zip files or folders prior to encryption with the `-z` option.
- Removes original files/folders after successful encryption.
- Auto-handles overwrites for zip archives, keeping your data safe.
- Helpful command-line error messages and prompts.

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

This is version **0.3.0**, the initial simple implementation.

## Author

👤 **Souvik Mitra**

- Github: [@magician79](https://github.com/magician79)

## License
Copyright © 2025 [Souvik Mitra](https://github.com/magician79).<br />
This project is licensed under the MIT License - see the [License File](LICENSE) for details.

---
