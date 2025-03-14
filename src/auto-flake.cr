require "./auto-flake/**"


module Auto::Flake
  VERSION = "0.1.0"

  LIBS = "--lib"
  PKGS = "--pkg"

  extend self

  private def get_hash_arguments(argv) : Tuple(String, String)
    args = Parser::Arguments.new argv
    Log::Error.show("Invalid arguments.") unless args.valid?
    Tuple.new(args.get(PKGS), args.get(LIBS))
  end

  def run(argv)
    pkgs, libs = get_hash_arguments argv
    buff = Buffer.create_buffer(pkgs, libs)
    Buffer.write_in_file(buff)
  end

end


Auto::Flake.run ARGV
