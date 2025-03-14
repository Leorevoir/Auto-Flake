module Auto::Flake::Buffer

  FILENAME = "flake.nix"
  BUFFER = [ "# /!\ auto-generated nix flake /!\\\n# do NOT edit !\n",
             "{",
             "  inputs = {",
             "    nixpkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\";",
             "    flake-utils.url = \"github:numtide/flake-utils\";",
             "  };",
             "  outputs = { self, nixpkgs, flake-utils }:",
             "    flake-utils.lib.eachDefaultSystem (system:",
             "      let",
             "        pkgs = import nixpkgs {",
             "          inherit system;",
             "        };",
             "      in",
             "      with pkgs; {",
             "        devShells.default = mkShell {",
             "          buildInputs = [",
             "          ];",
             "          shellHook = ''",
             "            export PKG_CONFIG_PATH=${pkgs.lib.makeLibraryPath [",
             "            ]}:$PKG_CONFIG_PATH",
             "            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [",
             "            ]}:$LD_LIBRARY_PATH",
             "          '';",
             "        };",
             "      });",
            "}"]

  def self.create_buffer(_pkgs : String, _libs : String) : Array(String)
    new_buff = [] of String

    BUFFER.each do |buff|
      new_buff << buff
      stripped = buff.strip

      case stripped
      when "buildInputs = ["
        _pkgs.split(' ').each { |pkg_| new_buff << "            #{pkg_}" }
        next
      when "export PKG_CONFIG_PATH=${pkgs.lib.makeLibraryPath ["
        _libs.split(' ').each { |lib_| new_buff << "            #{lib_}" }
        next
      when "export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath ["
        _libs.split(' ').each { |lib_| new_buff << "            #{lib_}" }
        next
      end
    end

    # Log::Debug.show new_buff
    new_buff
  end


  def self.write_in_file(_buffer : Array(String))
    File.open(FILENAME, "w") do |fd|
      fd.print _buffer.join('\n')
    end
  end


end

