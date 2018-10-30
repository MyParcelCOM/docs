#!/usr/bin/env bash
set -eo pipefail

cd ~/staging-docs.myparcel.com

echo "Removing current files..."
rm -rf public

echo "Unpacking files..."
tar -xzvf export.tar.gz

echo "Removing uploaded bundle..."
rm ./export.tar.gz
