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

# clone aichallenge-2024 and autoware-practice if they do not exist
cd ${AIC_HOME}
if [ ! -d "${AIC_HOME}/aichallenge-2024" ]; then
  git clone -b develop git@github.com:Roborovsky-Racers/aichallenge-2024.git ${AIC_HOME}/aichallenge-2024
fi
if [ ! -d "${AIC_HOME}/autoware-practice" ]; then
  git clone git@github.com:AutomotiveAIChallenge/autoware-practice.git  ${AIC_HOME}/autoware-practice
fi

# download AWSIM and AWSIM_GPU if they do not exist
AWSIM_CPU_FILE_ID="1EgkwC-vyuB1x9DZH7aqHeHc3nyhCTYU7";
AWSIM_GPU_FILE_ID="1yyGZpn-onEZU9SH101t3KMU0nLz3wSGI";
if [ ! -d "${AIC_HOME}/aichallenge-2024/aichallenge/simulator/AWSIM" ]; then
  curl -L "https://drive.usercontent.google.com/download?id=${AWSIM_CPU_FILE_ID}&export=download&confirm=y" -o AWSIM_CPU.zip
  unzip AWSIM_CPU.zip &
  curl -L "https://drive.usercontent.google.com/download?id=${AWSIM_GPU_FILE_ID}&export=download&confirm=y" -o AWSIM_GPU.zip
  unzip AWSIM_GPU.zip
  mv AWSIM_CPU ${AIC_HOME}/aichallenge-2024/aichallenge/simulator/
  mv AWSIM_GPU ${AIC_HOME}/aichallenge-2024/aichallenge/simulator/
  rm -rf AWSIM_CPU.zip AWSIM_GPU.zip
fi