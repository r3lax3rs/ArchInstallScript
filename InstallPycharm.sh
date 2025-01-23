#!/bin/bash
wget https://download.jetbrains.com/python/pycharm-community-2024.3.1.1.tar.gz
wait
sudo tar xzf pycharm-*.tar.gz -C /opt/
wait
sudo mv /opt/pycharm-* /opt/pycharm
wait
echo 'export PATH=/opt/pycharm/bin:$PATH' >> ~/.bashrc
wait
rm -rf pycharm-*
