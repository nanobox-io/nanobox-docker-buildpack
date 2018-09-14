# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='\u@\h:\w\$ '

# enable bash completion in interactive shells
if ! shopt -oq posix; then
 if [ -f /usr/share/bash-completion/bash_completion ]; then
   . /usr/share/bash-completion/bash_completion
 elif [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
 fi
fi

# Setup the herokuish environment

# Enable nullglobbing
shopt -s nullglob

# Set /app as $HOME
export HOME="/app"

# export the current session, which includes custom evars
# that were set when the container was started. - We don't
# want the buildpack to bulldoze those.
# (a few are ok to bulldoze though)
env \
  | grep -Ev 'PATH|PS1|TERM|SELF|SHLVL|PWD' \
  | sed -e 's/^/export /;' \
  > /etc/default_profile.sh

# Source all of the profile scripts within the app
if [ -d /app/.profile.d ]; then
  for i in /app/.profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# reset the default evars in case the buildpack bulldozed them
. /etc/default_profile.sh

# reset nullglobbing
shopt -u nullglob

# clear these commands from the history
hash -r
