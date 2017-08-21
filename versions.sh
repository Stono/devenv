#!/bin/bash
function versions() {
  echo "The following component versions are installed:"
  echo " - vim:       $(vim --version | head -n 1 | awk '{print $5}')"
  echo " - docker:    $(docker --version | awk '{print $3}' | sed -e 's/,//g')"
  echo " - compose:   $(docker-compose --version | awk '{print $3}' | sed -e 's/,//g')"
  echo " - nodejs:    $(node --version)"
  echo " - ruby:      $(ruby --version | awk '{print $2}')"
  echo " - gcloud:    $(gcloud --version | head -n 1 | awk '{print $4}')"
  echo " - kubectl:   $(kubectl version | head -n 1 | awk -F "\"" '{print $6}')"
  echo " - terraform: $(terraform --version | awk '{print $2}')"
  echo " - ansible:   $(ansible --version | head -n 1 | awk '{print $2}')"
}
versions
echo ""
