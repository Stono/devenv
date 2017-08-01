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
echo "Installed component version:"
echo " - vim:       $(vim --version | head -n 1 | awk '{print $5}')"
echo " - docker:    $DOCKER_VERSION"
echo " - compose:   $COMPOSE_VERSION"
echo " - nodejs:    $NODEJS_VERSION"
echo " - ruby:      $RUBY_VERSION"
echo " - gcloud:    $CLOUD_SDK_VERSION"
echo " - kubectl:   $KUBECTL_VERSION"
echo " - terraform: $TERRAFORM_VERSION"
echo " - ansible:   $(ansible --version | head -n 1 | awk '{print $2}')"

/bin/bash --login
