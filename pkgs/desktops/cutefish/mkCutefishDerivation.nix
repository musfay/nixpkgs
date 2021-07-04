{ lib, fetchFromGitHub, pkg-config, cmake, wrapGAppsHook, wrapQtAppsHook }:

{ category
, pname
, version
, attrPath ? "cutefish.${pname}"
, rev ? version
, sha256
, odd-unstable ? true
, patchlevel-unstable ? true
, ...
} @ args:

let
  inherit (builtins) filter getAttr head isList;
  inherit (lib) attrNames concatLists recursiveUpdate zipAttrsWithNames;

  filterAttrNames = f: attrs:
    filter (n: f (getAttr n attrs)) (attrNames attrs);

  concatAttrLists = attrsets:
    zipAttrsWithNames (filterAttrNames isList (head attrsets)) (_: concatLists) attrsets;

  template = rec {
    inherit pname version;

    nativeBuildInputs = [ cmake wrapGAppsHook wrapQtAppsHook ];

    src = fetchFromGitHub {
      owner = "cutefishos";
      repo = pname;
      inherit rev sha256;
    };

    enableParallelBuilding = true;
    outputs = [ "out" "dev" ];

    pos = builtins.unsafeGetAttrPos "pname" args;

    meta = with lib; {
      homepage = "https://cutefishos.com/";
      license = licenses.gpl3Plus;
      platforms = platforms.linux;
    };
  };

  publicArgs = removeAttrs args [ "pname" "sha256" ];
in

libsForQt5.mkDerivation (recursiveUpdate template publicArgs // concatAttrLists [ template args ])
