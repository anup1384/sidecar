#!/bin/bash

mkdir -p /root/logs/${CLIENT}
sed -i -e "s/NAME/${CLIENT}/g" /var/awslogs/etc/awslogs.conf
~                                                              
