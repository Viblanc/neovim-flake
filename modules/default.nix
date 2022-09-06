{ config, lib, pkgs, ... }: 
{
  imports = [
    ./core
    ./ui
    ./plugins
  ];
}
