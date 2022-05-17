#!/bin/sh

journalctl -f -u sshd -o json | grep -e Invalid -e Failed 

