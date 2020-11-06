#!/bin/bash

KEY_FILE=/vagrant/id_rsa.pub
rm -rf $KEY_FILE

ssh-keygen -q -t rsa -b 4096 -N '' -f /home/vagrant/.ssh/id_rsa
cat /home/vagrant/.ssh/id_rsa.pub >${KEY_FILE}