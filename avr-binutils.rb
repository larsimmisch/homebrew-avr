require 'formula'

class AvrBinutils < Formula
  url 'http://ftpmirror.gnu.org/binutils/binutils-2.23.1.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.1.tar.bz2'
  homepage 'http://www.gnu.org/software/binutils/binutils.html'
  sha1 '587fca86f6c85949576f4536a90a3c76ffc1a3e1'

  option 'without-libbfd', 'Disable installation of libbfd.'

  def install
    if MacOS.version == :lion
      ENV['CC'] = ENV.cc
    end

    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --target=avr
      --disable-nls
    ]

    if build.include? 'libbfd'
      chdir "bfd" do
        ohai "building libbfd"
        system "./configure", "--enable-install-libbfd", *args
        system "make"
        system "make install"
      end
    end

    if MacOS.version == :lion
      ENV['CC'] = ENV.cc
    end

    mkdir "build" do
      system "../configure", *args
      system "make"
      system "make install"
    end

    # taken from the gcc formula...
    # Even when suffixes are appended, the info pages conflict when
    # install-info is run. TODO fix this.
    info.rmtree
  end

  patch :p0 do
    # Support for -C in avr-size. See issue
    # https://github.com/larsimmisch/homebrew-avr/issues/9
    url "https://gist.github.com/larsimmisch/4190960/raw/b36f3d6d086980006f097ae0acc80b3ada7bb7b1/avr-binutils-size.patch"
    sha1 "b6d1ff7084b1f0a3fd2dee5383019ffb202e6c9a"
  end
end
