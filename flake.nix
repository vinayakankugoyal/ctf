{
  description = "CTF Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; 
        };

        pythonEnv = pkgs.python311.withPackages (ps: with ps; [
          pwntools
          requests
          ropper
          ipython
          numpy
          pillow
        ]);

      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # --- Reverse Engineering ---
            ghidra
            binwalk
            
            # --- Network & Forensics ---
            nmap
            netcat-gnu
            wireshark-cli
            file
            unzip
            poppler-utils
            exiftool
            qpdf
            zsteg
	    hexdump
            steghide
            
            # --- Scripting ---
            pythonEnv
          ];

          shellHook = ''
            echo "🚩 CTF Environment Loaded!"
            echo "Python Version: $(python --version)"
          '';
        };
      }
    );
}
