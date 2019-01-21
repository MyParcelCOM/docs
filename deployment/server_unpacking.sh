#!/usr/bin/env bash
set -eo pipefail

cd ~/staging-docs.myparcel.com

echo "Backing up spec files"
mv public/api-specification api-spec
mv public/carrier-specification carrier-spec

echo "Removing current files"
rm -rf public

echo "Unpacking files"
tar -xzvf export.tar.gz

echo "Putting spec files back"
mv api-spec public/api-specification
mv carrier-spec public/carrier-specification

echo "Removing uploaded bundle"
rm ./export.tar.gz
