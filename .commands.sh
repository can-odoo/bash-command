#!/bin/bash

# TODO: gt command conflicts with genometools, find unique command
# Command 'gt' not found, but can be installed with:
#sudo apt install genometools

# $1 $2 are positional args
# Create custom bash command: [1]
# After creating command file need to mention it on '.bashrc' file
# now you just need to run `runme.sh` file and util commands will be added


# global color variable
Green='\033[0;32m'
NC='\033[0m' # No Color (Resets color to default)

# Depending on your file path change the 'cd <odoo_module_path>'
# go to odoo/odoo_version/
function odv() {
    cd ;
    cd odoo/odoo_version/$1/community;
}

# git branch
function gb() {
    git branch
}

# git checkout <branch>
function gc() {
    git checkout $1
}

# git fetch, pull
function gp() {
    git pull;
    echo -e "${Green}git pull ${NC}";
}

# git fetch, pull
function gpll() {
    git fetch --all;
    echo -e "${Green}[success] git fetch --all ${NC}";

    git fetch --all -p;
    echo -e "${Green}[success] git fetch --all -p ${NC}";

    git pull;
    echo -e "${Green}[success] git pull ${NC}";
}

# connect to odoo-server
function obin() {
    # $1 - database name -> default is test
    # $2 - moule_name
    # $3 - port -> default is 8069

    # print command in terminal
    echo -e "${Green}./odoo-bin --addons-path=addons/,../enterprise -d ${1:-test} -i base,$2 --xmlrpc-port ${3:-8069} --dev=all${NC}";
    echo -e "\e]8;;http://google.com\alocalhost:${3}\e]8;;\a";

    # command execute
    ./odoo-bin --addons-path=addons/,../enterprise -d ${1:-test} -i base,$2 --xmlrpc-port ${3:-8069} --dev=all;
}



# ref:
# ----
# [1] https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e
