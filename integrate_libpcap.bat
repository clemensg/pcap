@echo off

echo Copying files...

set LIBPCAP_FOLDER=..\libpcap
set LIBPCAP_TEMP_FOLDER=.\libpcap_temp

rmdir /S /Q %LIBPCAP_TEMP_FOLDER% >NUL 2>NUL

mkdir %LIBPCAP_TEMP_FOLDER% >NUL

xcopy /s/e/v %LIBPCAP_FOLDER%\*.* %LIBPCAP_TEMP_FOLDER%\ >NUL

xcopy /s/e/v /y %LIBPCAP_TEMP_FOLDER%\*.* .\wpcap\libpcap >NUL

rmdir /S /Q %LIBPCAP_TEMP_FOLDER% >NUL

set LIBPCAP_FOLDER=
set LIBPCAP_TEMP_FOLDER=

echo Copying files -- Done

echo ---------------------------------------

REM echo Applying remote code patch...
REM pushd .\wpcap\libpcap\
REM patch -p1 -s < ..\libpcap-patches\remote_code.patch 
REM del /s *.orig >NUL 2>NUL
REM popd
REM echo Applying remote code patch -- Done

echo ---------------------------------------

echo DOS'ifing the libpcap makefile...
pushd .\wpcap\libpcap\win32\prj
unix2dos libpcap.dsp
popd
echo DOS'ifing the libpcap makefile -- Done

echo ---------------------------------------

echo Generating the compiler files...
pushd .\wpcap\prj\
call build_scanner_parser.bat
popd
echo Generating the compiler files -- Done







