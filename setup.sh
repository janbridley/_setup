# Install micromamba
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

# Set default channel to conda-forge
micromamba config append channels conda-forge

# Create a new environment
micromamba create -n 690py312 python=3.12
micromamba activate 690py312

# Install ovito python package
micromamba install --strict-channel-priority -c https://conda.ovito.org -c conda-forge ovito

# Install pyutils (private module)
git clone https://github.com/janbridley/pyutils.git
cd pyutils
pip install .
cd ..
rm -rf pyutils

# Set up function to ask for execution
prompt_and_execute() {
    read -p "$1 (y/n): " choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
        eval "$2"
    else
        echo "Command not executed."
    fi
}

# Attempt to change shell (optional)
prompt_and_execute "Do you want to try to change shell?" "chsh $(which zsh)"

# Add micromamba alias function to current shell
mmfun='

function mm() {
    case "$1" in
        "c" )
            shift
	    micromamba create -n "$1" "${@:2}"
	    #[[ $# -ge 2 ]] && conda create -n "$2" "${@:3}" || echo "Usage: mm create <environment_name>"
            ;;
        "a" | "activate")
            shift
            micromamba activate "$1"
            ;;
        "d" | "deactivate")
            micromamba deactivate
            ;;
        "i" | "install")
            shift
            micromamba install "$@"
            ;;
        "u" | "update")
            shift
            micromamba update "$@"
            ;;
	"ls" | "list")
	    shift
	    micromamba list "$@"
	    ;;
        "rm" | "remove")
            shift
            micromamba remove "$@"
            ;;
        *)
            # If no valid shortcut is specified, run 'conda' with the arguments
            micromamba "$@"
            ;;
    esac
}
'
read -p "Initialize mm mamba alias? (y=zshrc/n=bashrc): " choice

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]|| [ "$choice" == "zsh" ]; then
	# Append the lines to ~/.zshrc
	echo "$mmfun" >> ~/.zshrc
else
    # Append the lines to ~/.bashrc
	echo "$mmfun" >> ~/.bashrc
fi


# Install oh-my-zsh (optional)
prompt_and_execute "Do you want to install oh-my-zsh?" "sh -c \'$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\'"


echo "Setup complete :D"

