#!/bin/sh

echo "waiting..."
nohup ./watch_journal.sh >>journal.log 2>>journal_err.log &

echo "starting monitor journal log."
