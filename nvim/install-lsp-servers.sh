#!/bin/bash -xe

pip install 'python-lsp-server[all]'

gem install solargraph

d=/tmp/kotlin-language-server
if [[ ! -d "$d" ]]; then
    git clone --branch 1.3.1 git@github.com:fwcd/kotlin-language-server.git $d
fi
if [[ ! -f "/usr/local/bin/kotlin-language-server" ]]; then
    pushd $d
    ./gradlew :server:installDist
    sudo ln -s $PWD/server/build/install/server/bin/kotlin-language-server /usr/local/bin/kotlin-language-server
fi
