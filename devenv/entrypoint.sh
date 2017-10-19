#!/bin/bash
export TERM=xterm-256color

sred=$(tput setaf 1)
swhite=$(tput setaf 7)
sbold=$(tput bold)
snormal=$(tput sgr0)

function bold {
  echo "${sbold}$*${snormal}"
}

function red {
  echo "${sbold}${sred}$*${snormal}"
}

function white {
  echo "${swhite}$*${snormal}"
}

bold "Initialising development environment"
echo ""

GPG_KEY=/host/gpg.key
if [ ! -f "$GPG_KEY" ]; then
  red "WARNING: No GPG key found in $GPG_KEY"
  red " - git-crypt will not work!"
else
  bold Importing GPG key
  gpg --import $GPG_KEY
fi

echo ""

bold "The following components are installed:"
cat /.devenv-versions

bold "Setup complete."
/bin/bash --login
