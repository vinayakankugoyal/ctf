# CTF Environment

A reproducible Nix-based environment for Capture The Flag (CTF) competitions.

## Tools Included

### Reverse Engineering
*   **Ghidra**: Software reverse engineering (SRE) suite.
*   **Binwalk**: Firmware analysis tool.

### Network & Forensics
*   **Nmap**: Network discovery and security auditing.
*   **Netcat**: Networking utility (gnu variant).
*   **Wireshark (CLI)**: Network protocol analyzer.
*   **File/Unzip**: Basic file utilities.

### Scripting (Python 3.11)
*   **pwntools**: CTF framework and exploit development library.
*   **requests**: HTTP library.
*   **ropper**: ROP gadget finder.
*   **ipython**: Interactive Python shell.

## Usage

Enter the environment using Nix:

```bash
nix develop
```

This will load a shell with all tools available in your PATH.
