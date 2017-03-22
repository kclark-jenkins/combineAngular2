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

## Production use

To build your Angular2 project and use this script all in one step add something similar to the following to your package.json scripts

```
ng build --prod --no-sourcemap && ./combineAngular2.sh -f krisbox.min.js -d dist/inline.e25bbd8687f0d0b4dd15.bundle.js,dist/polyfills.dea81ef5f6ef31b15fb7.bundle.js,dist/vendor.7b5c5b89d5332450f2fb.bundle.js -o `pwd`/dist/ -m dist/main.b7233ad52b515d51079e.bundle.js -c `pwd`/combine.sh
```
