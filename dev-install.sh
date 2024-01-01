# AUTO DEV SETUP

# check if rye is installed
if ! command -v rye &> /dev/null
then
    echo "rye could not be found"
    echo "Would you like to install via rye or pip? Enter 'rye' or 'pip':"
    read install_method
    clear

    if [ "$install_method" = "rye" ]
    then
        echo "Installing via rye now ..."
        curl -sSf https://rye-up.com/get | bash
        echo "Check the rye docs for more info: https://rye-up.com/"
        source "$HOME/.rye/env"

        echo "SYNC: setup .venv"
        rye sync

        echo "ACTIVATE: activate .venv"
        rye shell

        clear

    elif [ "$install_method" = "pip" ]
    then
        echo "Installing via pip now ..."
        python3 -m venv .venv
        source .venv/bin/activate
        pip install -r requirements-dev.lock
        pip install -e .

    else
        echo "Invalid option. Please run the script again and enter 'rye' or 'pip'."
        exit 1
    fi

    clear
fi

echo "SETUP: install pre-commit hooks"
pre-commit install

echo "Try running 'python examples/simple_chatbot.py' to test your setup"
