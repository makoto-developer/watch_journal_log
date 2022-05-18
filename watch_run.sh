#!/bin/sh

echo "waiting..."
nohup ./watch.sh >>watch.log 2>>watch_err.log &

echo "starting deny network attack..."
