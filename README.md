# gpg-vault v0.1.0

Basic Bash script for symmetric encryption and decryption of files using GPG.

## Features

- Basic symmetric encryption of a single file
- Basic decryption of a single file
- Simple command-line interface

## Usage

### Decrypt a file
```sh
vault.sh -o <encrypted-file>
```

### Encrypt a file
```sh
vault.sh -l <file>
```

### Display help
```sh
vault.sh -h
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

This is version **0.1.0**, the initial simple implementation.

## Author

👤 **Souvik Mitra**

- Github: [@magician79](https://github.com/magician79)

## License
Copyright © 2025 [Souvik Mitra](https://github.com/magician79).<br />
This project is licensed under the MIT License - see the [License File](LICENSE) for details.

---
