module Auto::Flake::Log

  module Error

    def self.show(what : String)
      STDERR.puts "ERROR:\n\t#{what}\n\ttry with --help for usage."
      exit 84
    end

  end


  module Debug

    def self.show(what : String)
      puts "DEBUG:\n\t#{what}"
    end

    def self.show(what : Array)
      puts "DEBUG:"
      what.each { |w| puts "\t#{w}" }
    end

  end


end
