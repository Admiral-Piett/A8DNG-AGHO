#!/bin/bash

read_var() {
  VAR=$(grep $1 "${DIR}/app-variables.env" | xargs)
  IFS="=" read -ra VAR <<< "${VAR}"
  echo ${VAR[1]}
}

PYTHON_VERSION=3.9.1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if ! command -v pyenv &> /dev/null
then
  echo "pyenv not installed.  To run this natively on your machine please install pyenv - https://github.com/pyenv/pyenv#installation"
  exit 1
fi

pyenv install --skip-existing $PYTHON_VERSION
pyenv local $PYTHON_VERSION

#Set up interpreter path
$(pyenv which python) -m venv ./venv
echo "export PYTHONPATH=${PYTHONPATH}:${DIR}/src" >> ${DIR}/venv/bin/activate

# Set environment vars in the interpreter's environment
for var in "NOCLIST_DOMAIN" "NOCLIST_AUTH_REQUEST_PATH" "NOCLIST_USERS_REQUEST_PATH" "REQUEST_RETRY_THRESHOLD"
do
  echo "export ${var}=$(read_var $var)" >> ${DIR}/venv/bin/activate
done

source venv/bin/activate

#Install requirements
pip install -r requirements.txt
pip install -r test-requirements.txt
