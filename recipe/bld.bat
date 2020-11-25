pushd "%SRC_DIR%" || exit /b

rem Inline "installzlib.bat" and modify so it can be executed without MSYS
curl -O https://zlib.net/zlib1211.zip || exit /b
mkdir atari_py\ale_interface\src\zlib || exit /b
unzip zlib1211.zip || exit /b
xcopy /E zlib-1.2.11 atari_py\ale_interface\src\zlib || exit /b
pushd atari_py\ale_interface\src\zlib || exit /b 
cmake -DCMAKE_GENERATOR_PLATFORM=x64 . || exit /b
cmake --build . || exit /b

cd ..\.. || exit /b
mkdir build || exit /b
cp src\zlib\Debug\zlibstaticd.lib build\z.lib || exit /b
popd
rem End of inline

mkdir atari_py\ale_interface\build || exit /b
pushd atari_py\ale_interface\build || exit /b
cmake -DCMAKE_GENERATOR_PLATFORM=x64 .. || exit /b
cmake --build . || exit /b
copy Debug\ale_c.dll .. || exit /b
popd

"%PYTHON%" setup.py install || exit /b
popd
