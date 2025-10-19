@echo off
setlocal EnableDelayedExpansion

:: Variables
set APP_NAME=myapp-lib
set SRC_DIR=src
set BUILD_DIR=build
set LIB_DIR=lib
set TEST_LIB_DIR=..\sprint1\lib
set SERVLET_API_JAR=%LIB_DIR%\servlet-api.jar

:: Vérifier si Java est disponible
echo Vérification de Java...
java -version
if errorlevel 1 (
    echo Erreur: Java n'est pas installé ou non accessible dans le PATH!
    pause
    exit /b 1
)

:: Vérifier si le dossier lib existe
echo Vérification du dossier %LIB_DIR%...
if not exist %LIB_DIR% (
    echo Erreur: Le dossier %LIB_DIR% n'existe pas!
    echo Création du dossier %LIB_DIR%...
    mkdir %LIB_DIR%
    if errorlevel 1 (
        echo Erreur: Impossible de créer %LIB_DIR%!
        pause
        exit /b 1
    )
)

:: Vérifier si servlet-api.jar existe
echo Vérification de %SERVLET_API_JAR%...
if not exist %SERVLET_API_JAR% (
    echo Erreur: %SERVLET_API_JAR% n'existe pas!
    echo Téléchargez jakarta.servlet-api-5.0.0.jar depuis Maven Central
    echo ou copiez-le depuis C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28\lib
    pause
    exit /b 1
)

:: Vérifier si des fichiers .java existent dans src ou ses sous-dossiers
echo Vérification des fichiers sources dans %SRC_DIR%...
dir /b /s %SRC_DIR%\*.java > sources.txt
if not exist sources.txt (
    echo Erreur: Aucun fichier source n'a pu être listé!
    pause
    exit /b 1
)
for %%F in (sources.txt) do if %%~zF==0 (
    echo Erreur: Aucun fichier .java trouvé dans %SRC_DIR% ou ses sous-dossiers!
    echo Contenu de %SRC_DIR% :
    dir /s %SRC_DIR%
    del sources.txt
    pause
    exit /b 1
)

:: Afficher les fichiers trouvés
echo Fichiers .java trouvés :
type sources.txt

:: Nettoyage
echo Nettoyage du dossier %BUILD_DIR%...
if exist %BUILD_DIR% (
    rmdir /s /q %BUILD_DIR%
)
mkdir %BUILD_DIR%
if errorlevel 1 (
    echo Erreur: Impossible de créer %BUILD_DIR%!
    pause
    exit /b 1
)

:: Compilation
echo Compilation de la librairie %APP_NAME%...
javac -cp "%SERVLET_API_JAR%" -d %BUILD_DIR% @sources.txt
if errorlevel 1 (
    echo Erreur de compilation!
    del sources.txt
    pause
    exit /b 1
)
del sources.txt

:: Création du JAR
echo Création du JAR %APP_NAME%.jar...
cd %BUILD_DIR%
jar -cvf %APP_NAME%.jar .
if not exist %APP_NAME%.jar (
    echo Erreur: Échec de la création de %APP_NAME%.jar!
    cd ..
    pause
    exit /b 1
)
cd ..

:: Vérifier si le dossier de destination existe
echo Vérification du dossier %TEST_LIB_DIR%...
if not exist %TEST_LIB_DIR% (
    echo Création du dossier %TEST_LIB_DIR%...
    mkdir %TEST_LIB_DIR%
    if errorlevel 1 (
        echo Erreur: Impossible de créer %TEST_LIB_DIR%!
        pause
        exit /b 1
    )
)

:: Copie vers sprint1
echo Copie de %BUILD_DIR%\%APP_NAME%.jar vers %TEST_LIB_DIR%...
copy /Y %BUILD_DIR%\%APP_NAME%.jar %TEST_LIB_DIR%\
if errorlevel 1 (
    echo Erreur: Échec de la copie de %APP_NAME%.jar vers %TEST_LIB_DIR%!
    pause
    exit /b 1
)

echo.
echo Librairie %APP_NAME% buildée et copiée avec succès!
echo Fichier copié vers: %TEST_LIB_DIR%\%APP_NAME%.jar
echo.
pause