#!/bin/bash

# 安装node.js
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install nodejs -y -qq

# 安装ansible
apt-get install ansible -y -qq