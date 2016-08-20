@echo off
set MAKE=c:\MinGW\bin\mingw32-make.exe
call :build_assimp
rem call :build_bullet
call :build
goto :eof

:build_assimp
mkdir extern\assimp\build-js
mkdir extern\assimp\install-js
cd extern\assimp\build-js
call emcmake cmake^
 -DCMAKE_MAKE_PROGRAM=%MAKE%^
 -DCMAKE_INSTALL_PREFIX=..\install-js^
 -G "Unix Makefiles"^
 -DASSIMP_BUILD_TESTS=OFF^
 ..
call %MAKE% -j %NUMBER_OF_PROCESSORS%
call %MAKE% install
cd ..\..\..
goto :eof

:build_bullet
mkdir extern\bullet3\build-js
mkdir extern\bullet3\install-js
cd extern\bullet3\build-js
call emcmake cmake^
 -DCMAKE_MAKE_PROGRAM=%MAKE%^
 -DCMAKE_INSTALL_PREFIX=..\install-js^
 -G "Unix Makefiles"^
 -DBUILD_DEMOS=OFF^
 -DBUILD_UNIT_TESTS=OFF^
 ..
call %MAKE% -j %NUMBER_OF_PROCESSORS%
call %MAKE% install
cd ..\..\..
goto :eof

:build
mkdir build-html install-html
cd build-html
call emcmake cmake^
 -DCMAKE_MAKE_PROGRAM=%MAKE%^
 -DCMAKE_INSTALL_PREFIX=..\install-html^
 -G "Unix Makefiles"^
 ..
call %MAKE% -j %NUMBER_OF_PROCESSORS%
call %MAKE% install
cd ..
goto :eof