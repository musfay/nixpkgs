{ config, lib, pkgs }:

lib.makeScope pkgs.newScope (self: with self; {

  mkCutefishDerivation = callPackage ./mkCutefishDerivation.nix { };

})
