{
  description = "CTF Environment";

  inputs = {
    # Nixpkgs Unstable is good, but we will pin Python manually below
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    # FIX: You had a typo (extra slash) in the github URL below
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; 
        };

        # FIX: Changed 'pkgs.python3' (which is 3.13) to 'pkgs.python311'
        # Python 3.13 breaks pwntools asyncio features. 3.11 is the golden standard.
        pythonEnv = pkgs.python311.withPackages (ps: with ps; [
          pwntools
          requests
          ropper
          ipython
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