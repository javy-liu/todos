@echo off
echo [Pre-Requirement] Makesure install NodeJS and set PATH.
echo [Pre-Requirement] Makesure install Npm and set NODE_PATH.
echo [Pre-Requirement] Makesure install Grunt.

cd ../
echo [Step 1]  run npm install task.
call npm install
if errorlevel 1 goto error

echo [Step 2]  run grunt default task.
call grunt release
if errorlevel 1 goto error


goto end
:error
echo Error Happen!!
pause
exit 0

:end
exit 0