{ fetchFromGitHub, gperf, openssl, readline, zlib, cmake, lib, stdenv }:

stdenv.mkDerivation rec {
  pname = "tok-tdlib";
  version = "unstable-2021-05-21";

  src = fetchFromGitHub {
    owner = "tdlib";
    repo = "td";
    rev = "e1ebf743988edfcf4400cd5d33a664ff941dc13e";
    sha256 = "0db8w3i60pr35yy0mvl1hn8k8r2sqihyp828jw4nikgfhyxis2gj";
  };

  buildInputs = [ gperf openssl readline zlib ];
  nativeBuildInputs = [ cmake ];
}
