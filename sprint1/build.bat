@echo off

:: Variables
set APP_NAME=sprint1
set SRC_DIR=src
set BUILD_DIR=build
set LIB_DIR=lib
set MYAPP_LIB_JAR=%LIB_DIR%\myapp-lib.jar

:: Vérifier que myapp-lib.jar existe
if not exist %MYAPP_LIB_JAR% (
    echo Erreur: %MYAPP_LIB_JAR% n'existe pas!
    echo Executez d'abord deploy-lib.bat dans le projet myapp-lib
    pause
    exit /b 1
)

:: Nettoyage
if exist %BUILD_DIR% (
    rmdir /s /q %BUILD_DIR%
)
mkdir %BUILD_DIR%

:: Compilation
echo Compilation de l'application %APP_NAME%...
dir /b /s %SRC_DIR%\*.java > sources.txt
javac -cp "%MYAPP_LIB_JAR%" -d %BUILD_DIR% @sources.txt
if errorlevel 1 (
    echo Erreur de compilation!
    del sources.txt
    pause
    exit /b 1
)
del sources.txt

:: Exécution
echo Execution de Main.java...
java -cp "%BUILD_DIR%;%MYAPP_LIB_JAR%" test.urlAnnotations.Main

echo.
echo Test termine!
echo.
pause