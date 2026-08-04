# shellcheck shell=sh

####################
###### Prompt ######
####################

# The prompt is a particularly nasty config, so it's in its own file
. "$XDG_CONFIG_HOME/shell/prompt.bash"

#####################
###### History ######
#####################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTORYFILESIZE=2000

#############################
###### Terminal Window ######
#############################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

##################
###### Glob ######
##################

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
