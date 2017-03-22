#!/bin/bash
#
# Copyright 2017 Kristopher Clark
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
# IN THE SOFTWARE.

files=""
tempDir="tempDir"
dependenciesName="dependencies.js"
appName=""
origAppJavaScriptName=""
finalName="" 
finalOutputDir=""
combineScriptLocation=""

checkIfTempExists() {
  if [ -d "$tempDir" ]; then
    echo "$tempDir exists, removing"
    rm -rf $tempDir
  fi

  echo "Creating temporary directory $tempDir"
  mkdir $tempDir
}

makeCopiesOfJavaScript() {
   local counter=0
   for i in $(echo $files | sed "s/,/ /g")
   do
      local currentFile=$(compgen -W "$i")
      ((counter++))

      echo $currentFile
      echo "Copying" $currentFile "to $tempDir"
      cp $currentFile $tempDir/
   done
}

minifyCopiedJavaScript() {
  $combineScriptLocation ./$tempDir/*.js ./$tempDir/$1
  mkdir ./$tempDir/dependencies/
  echo "mv ./$tempDir/$1 ./$tempDir/dependencies/"
  mv ./$tempDir/$1 ./$tempDir/dependencies/
  rm ./$tempDir/*.js
}

minifyApplicationJavaScript() {
  cp $origAppJavaScriptName $tempDir/
  mv ./$tempDir/dependencies/dependencies.js ./$tempDir/
  rm -rf ./$tempDir/dependencies
  $combineScriptLocation ./$tempDir/$origAppJavaScriptName $tempDir/temp.min.js
  rm $tempDir/$origAppJavaScriptName
  combine
}

combine() {
  cat $tempDir/$dependenciesName $tempDir/temp.min.js > $tempDir/before.compression.js
  rm $tempDir/$dependencieName
  rm $tempDir/temp.min.js
  $combineScriptLocation $tempDir/before.compression.js $tempDir/$finalName
  rm $tempDir/dependencies.js
  rm $tempDir/before.compression.js
  mv $tempDir/$finalName $finalOutputDir/
  rm -rf $tempDir
}

showHelp() {
  echo "angularUnification.sh"
  echo ""
  echo "  Shell script that attempts to minify then unify your Angular2 application JavaScript in the correct order"
  echo ""
  echo "  Author: Kristopher Clark"
  echo "  License: MIT"
  echo "  Website: https://www.krisbox.org"
  echo ""
  echo "Dependencies:"
  echo "  This script requires you have Google Closure Compiler (http://dfsq.info/site/read/bash-google-closure-compiler) and that you pass it's location via -c"
  echo ""
  echo "Example usage:"
  echo ""
  echo "  angular2unification.sh -f krisbox.min.js -d vendor.bundle.js,inline.bundle.js -m main.bundle.js" -o /home/kclark/ -c /home/kclark/google-closure-compiler.sh
  echo ""
  echo "Arguments:"
  echo ""
  echo "  -f Final unified file name.   	 Example: krisbox.min.js"
  echo "  -d Application dependencies.  	 Example: /home/kclark/WebstormProjects/krisbox.org/dist/vendor.bundle.js,/home/kclark/WebstormProjects/krisbox.org/dist/somethingelse.js"
  echo "  -o Final output directory.    	 Example: /home/kclark/WebstormProjects/krisbox.org/dist/"
  echo "  -c Location of Google Closure Compiler Example: /home/kclark/google-closure-compiler.sh"
}

OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

while getopts "h:?:f:d:o:m:c:" opt; do
    case "$opt" in
    h|\?)
        showHelp
        exit 0
        ;;
    f)
	finalName=$OPTARG
	;;
    d)
	IN="$OPTARG"
	files=(${IN//;/ })
	;;
    o)
	finalOutputDir=$OPTARG
	;;
    m)
	origAppJavaScriptName=$OPTARG
	;;
    c)
	combineScriptLocation=$OPTARG
	;;
    esac
done

[ "$1" = "--" ] && shift

shift $((OPTIND-1))

checkIfTempExists
makeCopiesOfJavaScript
minifyCopiedJavaScript $dependenciesName
minifyApplicationJavaScript $appName
echo "Minification is done!"
