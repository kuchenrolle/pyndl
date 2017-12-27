#!/bin/bash

set -e
set -x

uname -a
python -c "import sys; print(sys.version)"

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    case "${TOXENV}" in
        py35)
            pyenv install 3.5.3
            pyenv virtualenv 3.5.3 pyndl
            ;;
        py36)
            pyenv install 3.6.3
            pyenv virtualenv 3.6.3 pyndl
            ;;

    esac
    pyenv rehash
    pyenv activate pyndl
fi

which python
pip install tox-travis