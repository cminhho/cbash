# CBASH HINT
```
 cbash CLI – OS X command line tools for developers 

VERSION: cbash/0.0.1

USAGE
  $ cbash [COMMAND] [<SUBCOMMAND> ...] [OPTIONS]

COMMANDS
cbash start Start services (i.e. start | start mysql)
cbash stop Stop services (i.e. stop | stop mysql)
cbash stats List all running containers with CPU, Memory, Networking I/O and Block I/O stats
cbash exec Execute a command in a running container
cbash status Show status of services
cbash ip Show ips of services
cbash log Show service log
cbash logs View output from containers
cbash list Show services in docker-compose
cbash restart Restart services
cbash reload Reload services

SETUP UTILITIES
cbash setup new Setting up environment for new macbook device (create workspace directories, install softwares, clone repos)
cbash setup workspace Create workspace directories 
cbash setup mac Install tools for setting up dev environment on brand new mac

GENERAL UTILITIES
kill <port> Kill app with port (i.e. kill 8194)
cash Convert currency rates directly from terminal
alias Alias functions for bash
login Login helper functions
boilr CLI tool for creating projects from boilerplate templates.

CLI UTILITIES
cbash cli changelog: Print the changelog
cbash cli help: Usage information
cbash cli plugin: Manage plugins
cbash cli pr: Manage CBASH Pull Requests
cbash cli reload: Reload the current zsh session
cbash cli update: Update CBASH
cbash cli install: Install CBASH
cbash cli version: Show the version

CHEATSHEET UTILITIES
cbash cheat init Write a default config file to stdout
cbash cheat l|list List cheatsheets
cbash cheat d|directories List cheatsheet directories
cbash cheat e|edit <cheatsheet> Edit <cheatsheet>
cbash cheat conf Display the config file path
cbash cheat rm <cheatsheet> Remove (delete) <cheatsheet>
cbash cheat p <cheatsheet> Open personal <cheatsheet>
cbash cheat <cheatsheet> Open <cheatsheet>

DOCUMENTS UTILITIES
cbash doc init Write a default config file to stdout
cbash doc l|list List cheatsheets
cbash doc d|directories List cheatsheet directories
cbash doc e|edit <cheatsheet> Edit <cheatsheet>
cbash doc c|conf Display the config file path
cbash doc k8s K8S documentation
cbash doc cab CAB instruction documentation
cbash doc aws-s3 CAB instruction documentation

K8S UTILITIES
cbash k8s K8s helper functions (i.e. cbash k8s pod-name-v1-67566f969-rl2wr)

MAC UTILITIES
cbash mac update Install macOS software updates, update installed Homebrew, npm, pip and their installed packages
cbash mac info Get macOS Info
cbash mac lock Lock Mac
cbash mac find:text Find text in current directory (cbash mac find:text mac md)
cbash mac search:replace Search and replace string on file (E.g.: search:replace /path/to/file.csv)
cbash mac memory See memory usage sorted by memory consumption
cbash mac ports List of used ports
cbash mac ip:local Get local IP address
cbash mac ip:public Get public IP address
cbash mac speedtest Internet connection speed test
cbash mac folder:size Calculate folder size
cbash mac folders:list List folders in current directory with their current size
cbash mac user:ls List user
cbash misc ips display all ip addresses for this host
cbash misc myip displays your ip address, as seen by the Internet
cbash misc passgen generates random password from dictionary words
cbash brew update Upgrade Homebrew, installed Homebrew packages, and cleanup

GIT REPOS UTILITIES
cbash repos Work across multiple repositories

GENERATION UTILITIES
cbash gen feat generate feature directories
cbash gen trouble generate trouble directories
cbash gen workspace generate workspace directories
cbash gen devbox generate devbox directories

AWS UTILITIES
cbash aws sm Use Azure AD SSO to log into the AWS CLI
cbash aws login Force login with aws-azure-login
cbash aws keys Helper function for AWS credentials file

AWS S3 UTILITIES
cbash s3 cp Copies S3 object to another location locally or in S3

SSM UTILITIES
cbash ssm sit SIT environment
cbash ssm uat UAT environment
cbash ssm prod PRD environment
cbash ssm c|conf Display the config file path

PROFILE UTILITIES
cbash profile reload . ~/.bash_profile
cbash profile apply replace & reload ~/.bash_profile
cbash profile open open ~/.bash_profile

GIT UTILITIES
cbash git undo-commit Undo latest commit
cbash git config Display local Git configuration
cbash git settings Check Git settings
cbash git clean Clean up the git repo and reduce its disk size
cbash git clones Git clone all repositories to local machine at DIRECTORY
cbash git clone <repo> clones a repo to local machine at DIRECTORY
cbash git cheatsheet Show Git cheatsheet
cbash git for Executes the given shell command in each project
cbash git forall Executes the given shell command in all projects
cbash git sync Downloads new changes and updates the working files in local environment
cbash git status Displays the state of the working directory and the staging area
cbash git diff Shows outstanding changes between the commit and the working tree
cbash git prune Prunes (deletes) topics that are already merged.
cbash git delete Delete all the git branches but "master", current branch, and every branch name you provide as argument
cbash git open Open current Git repository in browser
cbash git create:branch Create Git branch based on master branch
cbash git branch:rename Rename Git branch
cbash git branches Get last update date for all branches in current project
cbash git size Get size of current Git repository
cbash git backup Commit all current changes with backup message
cbash git branch <new-branch-name> Creates a new branch with the name "new-branch-name" and switches to it.
cbash git squash Squash Git commits by given branch and commit message.
cbash git auto:squash Squash all Git commits from the current feature branch.
cbash git auto:commit Automates some common Git tasks, such as adding, committing, and pushing changes.
cbash git create:pr Creates a pull request from the current branch to the  branch.'
```