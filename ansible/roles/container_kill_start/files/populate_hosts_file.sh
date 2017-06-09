#!/bin/bash
sed -i '/$hostname/d' /etc/hosts
echo "127.0.0.1 $(hostname)" >> /etc/hosts
cat /etc/hosts
