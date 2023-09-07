#!/bin/bash


# $1 $2 are positional args
# Create custom bash command: [1]
# After creating command file need to mention it on '.bashrc' file


# global color variable
Green='\033[0;32m'

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
    echo -e "${Green}git pull done ------------------------";
}

# git fetch, pull
function gpll() {
    git fetch --all;
    echo "${Green}git fetch --all done ------------------------";

    git fetch --all -p;
    echo "${Green}git fetch --all -p done ------------------------";

    git pull;
    echo "${Green}git pull done ------------------------";
}

# connect to odoo-server
function obin() {
    # $1 - database name -> default is test
    # $2 - moule_name
    # $3 - port -> default is 8069

    # print command in terminal
    echo -e "${Green}./odoo-bin --addons-path=addons/,../enterprise/ -d ${1:-test} -i base,$2 --xmlrpc-port ${3:-8069} --dev=all";

    # command execute
    ./odoo-bin --addons-path=addons/,../enterprise/ -d ${1:-test} -i base,$2 --xmlrpc-port ${3:-8069} --dev=all;
}



# ref:
# ----
# [1] https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e
