# combineAngular2

This simple bash script (depends on Google closure compiler) compresses and combines all of your Angular2 applications JavaScript
into a single distributable file.

## Usage

```
$ ./combineAngular2.sh -h

combineAngular2.sh

  Shell script that attempts to minify then unify your Angular2 application JavaScript in the correct order

  Author: Kristopher Clark
  License: MIT
  Website: https://www.krisbox.org

Dependencies:
  This script requires you have Google Closure Compiler (http://dfsq.info/site/read/bash-google-closure-compiler) and that you pass it's location via -c

Example usage:

  angular2unification.sh -f krisbox.min.js -d vendor.bundle.js,inline.bundle.js -m main.bundle.js -o /home/kclark/ -c /home/kclark/google-closure-compiler.sh

Arguments:

  -f Final unified file name.   	 Example: krisbox.min.js
  -d Application dependencies.  	 Example: /home/kclark/WebstormProjects/krisbox.org/dist/vendor.bundle.js,/home/kclark/WebstormProjects/krisbox.org/dist/somethingelse.js
  -o Final output directory.    	 Example: /home/kclark/WebstormProjects/krisbox.org/dist/
  -c Location of Google Closure Compiler Example: /home/kclark/google-closure-compiler.sh
```

Make sure you pass the JavaScript files to the script in the order you need them to be included.
