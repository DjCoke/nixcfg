{ config, ... }: { imports = [ 
    ./home.nix
    ../features/cli
    ../common
    ];
}
