#!/bin/sh

set -e

cat upstream.yaml | grep "upstream: " | awk '{print $NF}' | xargs -I{} git clone --depth 1 {}
