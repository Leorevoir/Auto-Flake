module Auto::Flake::Parser

  FLAGS = ["--lib", "--pkg"]
  USAGE = ["--help"]

  class Arguments

    property _args : Hash(String, String)
    property _size : Int32

    #//--{- PUBLIC -}--//#

    def initialize(args : Array(String))
      @_args = {} of String => String
      @_size = args.size

      Parser.usage unless @_size > 0
      check_usage args
      create_args_hash args
    end

    def valid?
      return false if @_args.empty?
      @_args.keys.all? { |key| FLAGS.includes?(key) }
    end

    def show
      @_args.each { |key, value| puts "#{key}: #{value}" }
    end

    #//--{- GETTERS -}--//#

    def get
      @_args
    end

    def get(key : String)
      @_args[key]? || ""
    end

    #//--{- PRIVATE -}--//#

    private def create_args_hash(args : Array(String))
      i = 0

      until i == @_size

        if args[i].starts_with?("--")
          key = args[i]

          if FLAGS.includes?(key)
            values = [] of String

            while i + 1 < @_size && !args[i + 1].starts_with?("--")
              values << args[i + 1]
              i += 1
            end

            @_args[key] = values.join(" ") unless values.empty?
          end
        end
        i += 1

      end
    end


    private def check_usage(args : Array(String))
      if args.any? { |arg| USAGE.includes?(arg) }
        Parser.usage
      end
    end

  end

  #//--{- MODULE-STATIC -}--//#

  def self.usage
    puts <<-EOF
    Welcome to auto-flake maintained by @Leorevoir.

    USAGE:
        auto-flake --pkg <packages> --lib <lib>

    DESCRIPTION:
        --pkg   Add valid nixpkgs
        --lib   Export libs
        --help  Show this help message
    EOF
    exit 0
  end

end
