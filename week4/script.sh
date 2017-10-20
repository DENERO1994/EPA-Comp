#!/bin/bash

var="aws ec2 describe-instance-status --instance-id $1 --query InstanceStatuses[*].InstanceState.Name --output text"

if [ var = "running" ]; the#n
 echo "instance running"
else
 echo "instance not running"
fi
