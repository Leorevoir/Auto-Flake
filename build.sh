#!/usr/bin/env bash

GREEN="\033[1;32m"
RED="\033[1;31m"
ILC="\033[3m"
BOLD="\e[1m"
ORANGE="\033[38;5;214m"
RST="\033[0m"
BIN_NAME="auto-flake"

function _error()
{
    echo -e "${RED}${BOLD}ERROR\n${RST}\t$1${ILC}\"$2\"${RST}"
    echo -e "\tTry ${ILC}$0${RST} --help for usage."
    exit 84
}

function _fclean()
{
    rm -f ${BIN_NAME}
    echo -e "${RED}[❌] FCLEAN: ${RST}${ILC}${BIN_NAME}${RST}"
}

function _all()
{
    crystal build --release --progress --stats -o auto-flake src/auto-flake.cr
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✅] COMPILED: ${RST} ${ILC}auto-flake$@${RST}"
        return
    fi
    _error "Build error " ":("
}

for args in "$@"
do
    case $args in
        -h|--help)
		cat << EOF
USAGE:
	$0 builds ${BIN_NAME)
        $0 [-h|--help] displays this message
        $0 [-f|--fclean] fclean the project
EOF
		exit 0
		;;
	-f|--fclean)
		_fclean
		exit 0
		;;
	*)
		_error "Invalid arguments: " $args
    esac

done

_all
