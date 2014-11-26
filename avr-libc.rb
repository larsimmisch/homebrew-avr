require 'formula'

class AvrLibc < Formula
  url 'http://download.savannah.gnu.org/releases/avr-libc/avr-libc-1.8.1.tar.bz2'
  homepage 'http://www.nongnu.org/avr-libc/'
  sha1 'b56fe21b30341869aa768689b0f6a07d896b17fa'

  depends_on 'avr-gcc'

  def install
    # empty CC allows ./configure to set it, based on the avr-gcc that it finds
    ENV.delete 'CC'

    build = `./config.guess`.chomp

    # specify our existing avr-gcc prefix as the prefix,
    # since that's where the toolchain is going to look for resources anyway
    args = %W[
      --prefix=#{Formula["avr-gcc"].prefix}
      --host=avr
      --build=#{build}
    ]

    mkdir "build" do
      system "../configure", *args
      system "make install"
    end
  end
end
