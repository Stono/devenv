#!/bin/bash
if [ -f /var/run/docker.sock ]; then
  sudo chown docker:docker /var/run/docker.sock
fi

echo "Development Environment"
echo "Installed component version:"
echo " - vim:       $(vim --version | head -n 1 | awk '{print $5}')"
echo " - docker:    $DOCKER_VERSION"
echo " - compose:   $COMPOSE_VERSION"
echo " - nodejs:    $NODEJS_VERSION"
echo " - ruby:      $RUBY_VERSION"
echo " - gcloud:    $CLOUD_SDK_VERSION"
echo " - kubectl:   $KUBECTL_VERSION"
echo " - terraform: $TERRAFORM_VERSION"

/bin/bash --login
