{ pkgs, inputs, plugins, ... }:
with builtins;
rec {
  defaultSystems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  mkPkgs = { nixpkgs, systems ? defaultSystems, cfg ? {}, overlays ? [] }:
  withSystems systems (sys:
    import nixpkgs {
      system = sys;
      config = cfg;
      overlays = overlays;
    });

  withDefaultSystems = withSystems defaultSystems;

  withSystems = systems: f:
  foldl' (cur: nxt:
          let
            ret = {
              "${nxt}" = f nxt;
            };
          in cur // ret) {} systems;

  neovimBuilder = { pkgs, lib ? pkgs.lib, config, ... }:
  let
    neovimPlugins = pkgs.neovimPlugins;

    vimOptions = lib.evalModules {
      modules = [
        { imports = [../modules]; }
        config
      ];

      specialArgs = {
        inherit pkgs;
      };
    };

    vim = vimOptions.config.vim;

  in pkgs.wrapNeovim pkgs.neovim-nightly {
    viAlias = vim.viAlias;
    configure = {
      customRC = vim.configRC;
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = vim.startPlugins;
        opt = vim.optPlugins;
      };
    };
  };

  buildPluginOverlay = import ./buildPlugin.nix { inherit pkgs inputs plugins; };
}
