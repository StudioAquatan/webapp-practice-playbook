#!/usr/bin/env bash

# To detect OS types
ostype() {
    uname | tr "[:upper:]" "[:lower:]"
}

case "$(ostype)" in
    *'linux'*)	PLATFORM='linux' ;;
    *'darwin'*)	PLATFORM='osx' ;;
    *'bsd'*)		PLATFORM='bsd' ;;
    *)			PLATFORM='unknown' ;;
esac

echo "[BEGIN] Install ansible on $(ostype)"

# processing based on PLATFORM
if [ "$PLATFORM" = "linux" ]; then
    echo "[SHELL] Confirm that ansible is installed"
    if type ansible > /dev/null 2>&1; then
        echo "[SHELL] Ansible has already been installed"
    else
        echo "[SHELL] Ansible has not been installed"
        # Apt update && upgrade
        echo "[APT] apt update && upgrade"
        sudo apt update -y && sudo apt upgrade -y

        # Install dependency
        echo "[APT] Install dependency"
        sudo apt install software-properties-common

        # Add repository of ansible
        echo "[APT] Add apt repository of ansible"
        sudo apt-add-repository ppa:ansible/ansible

        # Apt update
        sudo apt update -y

        # Install Ansible
        echo "[APT] Install ansible"
        sudo apt install ansible
    fi
elif [ "$PLATFORM" = "osx" ]; then
    echo "[SHELL] Confirm that Homebrew is installed"
    if type brew > /dev/null 2>&1; then
        echo "[SHELL] Homebrew is installed"
    else
        echo "[SHELL] Homebrew is not installed"
        echo "[SHELL] Install Homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    echo "[SHELL] Confirm that ansible is installed"
    if type ansible > /dev/null 2>&1; then
        echo "[SHELL] Ansible has already been installed"
    else
        echo "[SHELL] Ansible has not been installed"
        brew install ansible
    fi
fi

if type ansible > /dev/null 2>&1; then
    echo "[END] Ansible installed successfully"
    exit 0
else
    echo "[FAIL] Failed to install ansible"
    exit 1
fi

