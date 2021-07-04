{ mkDerivation, fetchFromGitHub ,lib, cmake, extra-cmake-modules,qttools, qtbase, qtquickcontrols2, qtx11extras, kwindowsystem }:

mkDerivation rec {
  pname = "fishui";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "cutefishos";
    repo = pname;
    rev = version;
    sha256 = "sha256-lNo6Sd82DK/GRyw57RsGrR2elpov2ws9ff6vODo+hiI=";
  };

  nativeBuildInputs = [ cmake qttools extra-cmake-modules ];
  buildInputs = [ qtbase kwindowsystem qtquickcontrols2 qtx11extras ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "/usr/lib/cmake" "$out/lib/cmake"
  '';

  meta = with lib; {
    description = "GUI library based on Qt Quick Controls 2";
    homepage = "https://cutefishos.com/";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
