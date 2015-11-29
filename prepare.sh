#!/bin/bash

set -x
rm -rf cookbooks
mkdir cookbooks
cd cookbooks

git clone https://github.com/karuru6225/cookbook-bash.git bash
git clone https://github.com/karuru6225/cookbook-basic-packages.git basic-packages
git clone https://github.com/karuru6225/cookbook-vim.git vim
git clone https://github.com/karuru6225/cookbook-github.git github
