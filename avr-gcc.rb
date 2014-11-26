require 'formula'

class AvrGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "http://ftpmirror.gnu.org/gcc/gcc-4.8.3/gcc-4.8.3.tar.bz2"
  mirror "ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.8.3/gcc-4.8.3.tar.bz2"
  sha1 'da0a2b9ec074f2bf624a34f3507f812ebb6e4dce'

  depends_on 'avr-binutils'
  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on "isl"
  depends_on "cloog"

  option 'without-cxx', 'Don\'t build the g++ compiler'

  def install
    languages = %w[c]
    languages << "c++" if build.with?("cxx")

    args = %W[
      --prefix=#{prefix}
      --target=avr
      --disable-libssp
      --disable-nls
      --with-dwarf2
      --disable-install-libiberty
      --with-system-zlib
      --enable-languages=#{languages.join(",")}
      --with-as=#{Formula["avr-binutils"].bin}/avr-as
      --with-ld=#{Formula["avr-binutils"].bin}/avr-ld
    ]

    mkdir "build" do
      system '../configure', *args
      system 'make'
      system 'make install'
    end

  end
end
