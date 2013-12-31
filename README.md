# starcheat

Starbound player save editor, you can get free pixels with this (omg)

*If you are looking for prebuilt Mac OSX and Windows builds, check the Starbound community link below*

- mod db: http://community.playstarbound.com/index.php?resources/starcheat.699/

![woohoo](https://raw.github.com/wizzomafizzo/starcheat/master/screen.png)

## Install Instructions
How to install starcheat on your system

### Prerequisites
- [python 3](http://www.python.org/getit/)
- [qt 5](http://qt-project.org/downloads) (if you're using Windows you probably don't need this)
- [pyqt5](http://www.riverbankcomputing.com/software/pyqt/download5)
- [cx_freeze](http://cx-freeze.sourceforge.net/) (Only for standalone builds)

### Windows
- PS> cd \<starcheat top folder\>
- PS> ./build.ps1
- browse to newly created build/ folder
- double click starcheat.py

### Standalone build (Windows Only)
Uses cx_freeze to create a standalone executable with all of the prerequisites included

- PS> cd \<starcheat top folder\>
- PS> ./build.ps1 -Standalone
- browse to newly created dist/ folder
- double click starcheat.exe

If Windows complains about a system error when running the executable (re: missing msvcr100.dll) you probably need to install the [VS C++ 2010 Runtime Redistributable](http://www.microsoft.com/en-US/download/details.aspx?id=14632)

### Linux
- $ cd \<starcheat top folder\>
- $ ./build.sh
- $ cd build/
- $ ./starcheat.py
