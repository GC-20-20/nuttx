#!/usr/bin/env bash
############################################################################
# tools/showstack.sh
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.  The
# ASF licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.
#
############################################################################

function analyse()
{
  sufiles=$(find $1 -name "*.su")
  if [[ $sufiles != "" ]]
  then
    echo $sufiles | xargs -n1 cat | awk -F'\t' '{print $2", "$1}' | sort -n -r | head -n $2
  fi
}

if [[ $# == 0 ]]; then
  echo "usage: $0 <rank> <dir>..."
  exit
fi

rank=20

if [[ "$1" =~ ^[0-9]+$ ]]; then
  rank=$1
  shift
fi

for dir in $@; do
  analyse $dir $rank
done
