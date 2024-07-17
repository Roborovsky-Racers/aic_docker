#!/bin/bash

DEFAULT_AIC_HOME="${HOME}/aic"
if [ -z "${AIC_HOME}" ]; then
  echo "Warn: Environment variable 'AIC_HOME' is not set."

  read -p "Do you want to use the default value '$DEFAULT_AIC_HOME'? (y/n): " choice

  if [ "$choice" = "y" ]; then
    AIC_HOME=$DEFAULT_AIC_HOME
    echo "Using default value: ${AIC_HOME}"
  else
    echo "Aborted."
    exit 1
  fi
fi
echo "'AIC_HOME' is set to '${AIC_HOME}'"

# clone aic_docker if it does not exist
if [ ! -d "${AIC_HOME}/aic_docker" ]; then
  git clone git@github.com:Roborovsky-Racers/aic_docker.git ${AIC_HOME}/aic_docker
fi

cd ${AIC_HOME}
git clone -b develop git@github.com:Roborovsky-Racers/aichallenge-2024.git ${AIC_HOME}/aichallenge-2024
git clone git@github.com:AutomotiveAIChallenge/autoware-practice.git  ${AIC_HOME}/autoware-practice
