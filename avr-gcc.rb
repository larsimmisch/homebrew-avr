require 'formula'

def nocxx?
  ARGV.include? '--disable-cxx'
end

# print avr-gcc's builtin include paths
# `avr-gcc -print-prog-name=cc1plus` -v

class AvrGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  md5 'cc308a0891e778cfda7a151ab8a6e762'

  depends_on 'larsimmisch/avr/avr-binutils'
  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'

  def options
    [
     ['--disable-cxx', 'Don\'t build the g++ compiler'],
    ]
  end

  # Dont strip compilers.
  skip_clean :all

  def install
    gmp = Formula.factory 'gmp'
    mpfr = Formula.factory 'mpfr'
    libmpc = Formula.factory 'libmpc'

    # brew's build environment is in our way
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV.delete 'AS'
    ENV.delete 'LD'
    ENV.delete 'NM'
    ENV.delete 'RANLIB'

    if MacOS.lion?
      ENV['CC'] = 'llvm-gcc'
    end

    args = [
            "--target=avr",
            "--disable-libssp",
            "--disable-nls",
            "--with-dwarf2",
            # Sandbox everything...
            "--prefix=#{prefix}",
            "--with-gmp=#{gmp.prefix}",
            "--with-mpfr=#{mpfr.prefix}",
            "--with-mpc=#{libmpc.prefix}",
            # ...except the stuff in share...
            "--datarootdir=#{share}",
            # ...and the binaries...
            "--bindir=#{bin}",
            # This shouldn't be necessary
            "--with-as=/usr/local/bin/avr-as"
           ]

    # The C compiler is always built, C++ can be disabled
    languages = %w[c]
    languages << 'c++' unless nocxx?

    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system '../configure', "--enable-languages=#{languages.join(',')}", *args
      system 'make'

      # At this point `make check` could be invoked to run the testsuite. The
      # deja-gnu and autogen formulae must be installed in order to do this.

      system 'make install'

      multios = `gcc --print-multi-os-dir`.chomp

      # binutils already has a libiberty.a. We remove ours, because
      # otherwise, the symlinking of the keg fails
      File.unlink "#{prefix}/lib/#{multios}/libiberty.a"

    end
  end
end

 
