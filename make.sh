#!/bin/sh

mkdir -p ebin
for FILE in src/*.erl; do
  erlc -o ebin $FILE
done
