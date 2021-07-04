{ config, lib, pkgs }:

lib.makeScope pkgs.newScope (self: with self; {

  fishui = pkgs.libsForQt5.callPackage ./fishui { };

})
