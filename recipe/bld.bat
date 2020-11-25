SETLOCAL EnableDelayedExpansion

pushd "%SRC_DIR%" || exit /b !ERRORLEVEL!

rem Inline "installzlib.bat" and modify so it can be executed without MSYS
curl -O https://zlib.net/zlib1211.zip || exit /b !ERRORLEVEL!
mkdir atari_py\ale_interface\src\zlib || exit /b !ERRORLEVEL!
unzip -o zlib1211.zip || exit /b !ERRORLEVEL!
xcopy /E zlib-1.2.11 atari_py\ale_interface\src\zlib || exit /b !ERRORLEVEL!
pushd atari_py\ale_interface\src\zlib || exit /b !ERRORLEVEL!
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release . || exit /b !ERRORLEVEL!
cmake --build . || exit /b !ERRORLEVEL!

cd ..\.. || exit /b !ERRORLEVEL!
mkdir build || exit /b !ERRORLEVEL!
copy src\zlib\zlibstatic.lib build\z.lib || exit /b !ERRORLEVEL!
popd
rem End of inline

pushd atari_py\ale_interface\build || exit /b !ERRORLEVEL!
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release .. || exit /b !ERRORLEVEL!
cmake --build . || exit /b !ERRORLEVEL!
copy ale_c.dll .. || exit /b !ERRORLEVEL!
popd

"%PYTHON%" setup.py install || exit /b !ERRORLEVEL!
popd
