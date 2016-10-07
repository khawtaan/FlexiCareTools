@echo off
rem ###########################################################################
rem #
rem # FILE NAME: FlexiCare-HC.bat
rem # VERSION: 1.0 (5 Oct 16)
rem # Compatible only WINDOWS operation system
rem #
rem ###########################################################################
rem
rem ###########################################################################
rem #
rem # Created by Chat P. (Consultant)
rem #
rem # This Customize menu for convenient and flexibility during the Consultant
rem # go on-site support for the Quarterly Maintenance.
rem #
rem ##########################################################################

rem Environment Set
set title_name=- FlexiCare tools for Quarterly Maintenance -

TITLE %title_name%
cls

rem Warning the script should be running on
echo Warning!!!
echo.   If you want to run SAA supportinfo
echo.       It should be run from the Command Prompt of the Alliance Installation application !!!
echo.   If you want to run SAG ^& SNL supportinfo
echo.       It should be run from the Command Prompt of the SWIFTNet link !!!
echo.

if defined QMdir goto qmdir_check
echo Folder does not exist. Please enter path to FlexiCare folder (Defaut: SWIFTSupport\QM\_YYYYMMMDD-Purpose_)
echo ~Path must not contain " or end with \ or has space.
set /P QMdir=Path:

:qmdir_check
if exist %QMdir% goto pre_menu
echo Path "%QMdir%" does not exist. Please recheck the name folder again.
choice /m "Recheck exist path again :"
echo.
if errorlevel 2 goto endoffile
goto qmdir_check

:pre_menu
set app_path=%__CD__%

:menu
cls
cd %app_path%
TITLE %title_name% ~ Main Menu
echo FlexiCare folder: %QMdir%
echo.
echo ##########################################
echo ### Select an option by enter a number ###
echo ##########################################
echo.
echo Menu :
echo 1). Generate supportinfo of SAA/E
echo 2). Generate supportinfo of SWPSE
echo 3). Generate supportinfo of SAG
echo 4). Generate supportinfo of SNL
echo.
echo Optional 5). Create QM subfolder (Path : %QMdir%)
echo.
echo 0). Exit
echo.
choice /C 123450 /N /m "Enter the number:"
if errorlevel 6 goto endoffile
if errorlevel 5 goto option5
if errorlevel 4 goto menu_4
if errorlevel 3 goto menu_3
if errorlevel 2 goto menu_2
if errorlevel 1 goto menu_1

:option5
cls
cd %QMdir%
TITLE %title_name% ~ Create QM subfolder
echo Optional 5). Create QM subfolder (Default: %QMdir%)
echo.
echo ##########################################
echo ### Select an option by enter a number ###
echo ##########################################
echo.
echo 1). Create subfolder of BACKUP / HealthCheck (SAA_E ^& SWPSE)
echo 2). Create subfolder of BACKUP / HealthCheck (SAA_E ^& SWPSE ^& SAG ^& SNL)
echo.
echo Optional
echo 3). Create subfolder of BACKUP / HealthCheck (SAA_E)
echo 4). Create subfolder of BACKUP / HealthCheck (SWPSE)
echo 5). Create subfolder of BACKUP / HealthCheck (SAG ^& SNL)
echo.
echo 0). Back to main menu
echo.
choice /C 123450 /N /m "Enter the number:"
if errorlevel 6 goto menu
if errorlevel 5 goto option5_5
if errorlevel 4 goto option5_4
if errorlevel 3 goto option5_3
if errorlevel 2 goto option5_2
if errorlevel 1 goto option5_1

rem ### menu_4
:menu_4
cls
echo Start generate the SNL supportinfo file.
echo Status
call HCCollector.bat o=%QMdir%\1-HealthCheck\SNL check=SNL
echo SNL supporinfo ... (Done)
pause
goto menu
rem ###

rem ### menu_3
:menu_3
cls
echo Start generate the SAG supportinfo file.
echo Status
call HCCollector.bat o=%QMdir%\1-HealthCheck\SAG check=SAG
echo SAG supporinfo ... (Done)
pause
goto menu
rem ###

rem ### menu_2
:menu_2
cls
echo Start generate the SWPSE supportinfo file.
echo Status
call HCCollector.bat o=%QMdir%\1-HealthCheck\SWPSE check=AWPSE
echo SWPSE supporinfo ... (Done)
pause
goto menu
rem ###

rem ### menu_1
:menu_1
cls
echo Start generate the SAA supportinfo file.
echo Status
call HCCollector.bat o=%QMdir%\1-HealthCheck\SAA_E check=SAA
echo SAA supporinfo ... (Done)
pause
goto menu
rem ###

rem ### option5_5
:option5_5
choice /m "Do you want to create subfolder of BACKUP / HealthCheck (SAG & SNL):"
if errorlevel 2 goto option5
echo | set /p=Check existing folder name
if not exist 0-Backup goto next1_option5_5
echo ... (Existing)
pause
goto option5

:next1_option5_5
echo ... (Not exist)
echo | set /p=Creating subfolder
mkdir 0-Backup & mkdir 1-HealthCheck
cd 0-Backup & mkdir SAG & mkdir SNL & cd ..
cd 1-HealthCheck & mkdir SAG & mkdir SNL & cd ..
echo ... (Done)
pause
goto option5
rem ###

rem ### option5_4
:option5_4
choice /m "Do you want to create subfolder of BACKUP / HealthCheck (SWPSE):"
if errorlevel 2 goto option5
echo | set /p=Check existing folder name
if not exist 0-Backup goto next1_option5_4
echo ... (Existing)
pause
goto option5

:next1_option5_5
echo ... (Not exist)
echo | set /p=Creating subfolder
mkdir 0-Backup & mkdir 1-HealthCheck
cd 0-Backup & mkdir SWPSE & cd ..
cd 1-HealthCheck & mkdir SWPSE & cd ..
echo ... (Done)
pause
goto option5
rem ###

rem ### option5_3
:option5_3
choice /m "Do you want to create subfolder of BACKUP / HealthCheck (SAA_E):"
if errorlevel 2 goto option5
echo | set /p=Check existing folder name
if not exist 0-Backup goto next1_option5_3
echo ... (Existing)
pause
goto option5

:next1_option5_3
echo ... (Not exist)
echo | set /p=Creating subfolder
mkdir 0-Backup & mkdir 1-HealthCheck
cd 0-Backup & mkdir SAA_E & cd ..
cd 1-HealthCheck & mkdir SAA_E & cd ..
echo ... (Done)
pause
goto option5
rem ###

rem ### option5_2
:option5_2
choice /m "Do you want to create subfolder of BACKUP / HealthCheck (SAA_E & SWPSE & SAG & SNL):"
if errorlevel 2 goto option5
echo | set /p=Check existing folder name
if not exist 0-Backup goto next1_option5_2
echo ... (Existing)
pause
goto option5

:next1_option5_2
echo ... (Not exist)
echo | set /p=Creating subfolder
mkdir 0-Backup & mkdir 1-HealthCheck
cd 0-Backup & mkdir SAA_E & mkdir SWPSE & mkdir SAG & mkdir SNL & cd ..
cd 1-HealthCheck & mkdir SAA_E & mkdir SWPSE & mkdir SAG & mkdir SNL & cd ..
echo ... (Done)
pause
goto option5
rem ###

rem ### option5_1
:option5_1
choice /m "Do you want to create subfolder of BACKUP / HealthCheck (SAA_E & SWPSE):"
if errorlevel 2 goto option5
echo | set /p=Check existing folder name
if not exist 0-Backup goto next1_option5_1
echo ... (Existing)
pause
goto option5

:next1_option5_1
echo ... (Not exist)
echo | set /p=Creating subfolder
mkdir 0-Backup & mkdir 1-HealthCheck
cd 0-Backup & mkdir SAA_E & mkdir SWPSE & cd ..
cd 1-HealthCheck & mkdir SAA_E & mkdir SWPSE & cd ..
echo ... (Done)
pause
goto option5
rem ###

:endoffile
echo Exit - FlexiCare tools
cd %app_path%
