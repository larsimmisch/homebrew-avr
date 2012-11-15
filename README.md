Homebrew-avr
============
This repository contains the GNU AVR toolchain as formulae for [Homebrew](https://github.com/mxcl/homebrew).

AVR is a popular family of microcontrollers, used for example in the [Arduino](http://arduino.cc) project.

	
Current Versions
----------------
- gcc 4.7.2
- binutils 2.23.1
- avr-libc 1.8.0

Dependencies: 'gmp', 'libmpc', 'mpfr' will be installed with gcc.

Installing Homebrew-avr Formulae
--------------------------------
Just `brew tap larsimmisch/avr` and then `brew install <formula>`.

To install the entire AVR toolchain, do:
`brew install avr-libc`

This will pull in the prerequisites avr-binutils and avr-gcc.

You can also install via URL:

```
brew install https://raw.github.com/larsimmisch/homebrew-avr/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki][].

[wiki]:http://wiki.github.com/mxcl/homebrew
[homebrew-dupes]:https://github.com/Homebrew/homebrew-dupes
[homebrew-versions]:https://github.com/Homebrew/homebrew-versions
