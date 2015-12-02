#!/bin/bash
root_dir=$(cd "$(dirname "$0")"; pwd)
pushd $root_dir
rsync -av --exclude-from=rsyncexclude  . ~
popd