<#
Starcheat Windows build script

This will generate a clean build folder with all necessary files to run
starcheat with dependencies installed. It can also, optionally, generate
a standalone executable package.

For the end user, a script build will require python 3 and pyqt5 as
dependencies. A standalone build does not need any python or Qt dependencies
but may need the VS2010 C++ Runtime package installed from here:
http://www.microsoft.com/en-au/download/details.aspx?id=14632

Usage:
- Create script build:
  > ./build.ps1
- Plus standalone package:
  > ./build.ps1 -Standalone
#>

Param([switch]$Standalone)

$build_folder = ".\build"
$starcheat_folder = ".\starcheat"
# default python install does not modify PATH, we'll specify manually
$reg_path = 'HKLM:\SOFTWARE\Python\PythonCore\3.3\InstallPath'
$python_folder = Get-ItemProperty $reg_path | Select-Object -ExpandProperty "(Default)"
$pyqt5_folder = $python_folder + "\Lib\site-packages\PyQt5"
$pyuic5_exe = $pyqt5_folder + "\pyuic5.bat"
$cx_freeze_exe = $python_folder + "\Scripts\cxfreeze.bat"

Write-Host "Starting starcheat Windows build..."

if (Test-Path $build_folder) {
    Write-Host "Removing existing build directory"
    Remove-Item -Recurse -Force $build_folder
}

Write-Host "Creating empty build directory"
New-Item -Type directory -Path $build_folder | Out-Null

Write-Host "Copying starcheat python scripts"
Copy-Item ($starcheat_folder + "\*.py") $build_folder

Write-Host "Generating python Qt templates..."
$ui_files = Get-ChildItem ($starcheat_folder + "\templates\*.ui")
$ui_files | %{
    $py_name = "qt_" + $_.Name.Split(".")[0].ToLower() + ".py"
    & $pyuic5_exe ($starcheat_folder + "\templates\" + $_.Name) `
        | Out-File -Encoding "UTF8" ($build_folder + "\" + $py_name)
    Write-Host "Generated $py_name"
}

Write-Host "Script build is complete!"

if ($Standalone) {
    # cx_freeze decides this
    $dist_folder = ".\dist"
    if (Test-Path $dist_folder) {
        Write-Host "Removing existing dist directory"
        Remove-Item -Recurse -Force $dist_folder
    }
    Write-Host "Starting starcheat standalone Windows build..."
    Write-Host "Launching cx_freeze..."
    & $cx_freeze_exe ($build_folder + "\starcheat.py")
    # Possible bug in cx_freeze, need to manually copy this dll
    Copy-Item ($pyqt5_folder + "\libEGL.dll") $dist_folder
	Write-Host "Copying debug utils..."
	Copy-Item ($starcheat_folder + "\*.bat") $dist_folder
    Write-Host "Standalone build is complete!"
}