# bash-command 🧑‍💻
Introducing some custom shorthand git and Odoo commands so that we can save our precious time.

## Steps to setup (automatic):
1. Clone the repo
2. go to the clone location
3. run `sh runme.sh` 🏃 **(That's it!)**

### Steps to setup (manually):
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
  * e.g. <br/>
   ![o_version_structure](https://github.com/can-odoo/bash-command/assets/84001602/60ccd64f-dde4-4a18-a343-709d579dea8b)

* `obin`:
  * with default params ->  obin
  * pass params -> `obin "database_name" "module_name" "port"`
  * you can leave it empty if you want to pass default parma here for module_name-> `obin "db" "" "port"`

**NOTE:** `.command.sh` and `.bashrc` were dot files meaning hidden files so to make it visible press `ctrl + h` and modify.
