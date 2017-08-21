#!/bin/bash
if [ -f /var/run/docker.sock ]; then
  sudo chown docker:docker /var/run/docker.sock
fi

echo "Initialising development environment"
echo ""

GPG_KEY=/host/gpg.key
if [ ! -f "$GPG_KEY" ]; then
  echo "WARNING: No GPG key found in $GPG_KEY"
  echo " - git-crypt will not work!"
else
  echo Importing GPG key
  gpg --import $GPG_KEY
fi

echo ""

cat /.devenv-versions

/bin/bash --login
