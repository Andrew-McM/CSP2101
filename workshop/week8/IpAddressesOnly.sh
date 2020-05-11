#!/bin/bash

ipAddress=$(~/CSP2101/workshop/week8/IpInfo.sh | sed -n '/IP Address/ {
    p
}')

echo $ipAddress