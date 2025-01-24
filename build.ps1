$env:JAVA_HOME = "$env:USERPROFILE\scoop\apps\temurin21-jdk\current"
# $env:Path = $env:JAVA_HOME + '\bin;' + $env:Path

Write-Host ">>> Java Home: $env:JAVA_HOME"

& "$env:JAVA_HOME\bin\java.exe" -version
java -version

Write-Host ">>> Fetching dependencies"
gradle -I gradle/support/fetchDependencies.gradle init

Write-Host ">>> Preparing Ghidra development environment (Eclipse plugin)"
gradle prepdev cleanEclipse eclipse buildNatives
gradle sleighCompile
gradle createJavadocs
gradle buildPyPackage

Write-Host ">>> Building Ghidra"

## Uncompressed form:
gradle assembleAll -x ip

explorer .\build\dist\

## Compressed distribution:
# gradle buildGhidra -x ip
