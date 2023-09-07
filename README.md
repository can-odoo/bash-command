# bash-command 🧑‍💻
Introducing some custom shorthand git and Odoo commands so that we can save our precious time.

### Steps to setup:
1. Clone the repo
2. copy file path of `.commands.sh`
3. open `~/.bashrc` in any text editor
4. Add the following command after the last line `source ~/<copied_file_path_of_.commands.sh>`
5. Restart the terminal and good to go

### Commands
* `gc <branch_name>` => will checkout to branch_name
* `gb` git branch (will show local brnachs)
* `gp` => git pull
* `gpall` => will do `git fetch --all` `git fetch --all -p` `git pull`
* `odv` This command will depend on file structure/directory_name of Odoo repo

**NOTE:** `.command.sh` and `.bashrc` were dot files means hidden files so to make it visible press `ctrl + h` and modify.
