#!/usr/bin/env bash
#
#/**
# * Copyright 2015 The Apache Software Foundation
# *
# * Licensed to the Apache Software Foundation (ASF) under one
# * or more contributor license agreements.  See the NOTICE file
# * distributed with this work for additional information
# * regarding copyright ownership.  The ASF licenses this file
# * to you under the Apache License, Version 2.0 (the
# * "License"); you may not use this file except in compliance
# * with the License.  You may obtain a copy of the License at
# *
# *     http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */
# 
# Manage a zookeeper service
#

usage="Usage: zk-service.sh (start|stop)"

if [ $# -le 0 ]; then
  echo $usage
  exit 1
fi
  
bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`
zkbin=$bin/../thirdparty/zookeeper-3.4.6/bin

#echo $zkbin

if [ "$SINGA_MANAGES_ZK" = "" ]; then
  SINGA_MANAGES_ZK=true
fi

#echo 'SINGA_MANAGES_ZK='$SINGA_MANAGES_ZK

#get argument
cmd=$1

case $cmd in

(start)
  #start zk service
  if [ "$SINGA_MANAGES_ZK" = "true" ]; then
    #check zoo,cfg
    if [ ! -f $zkbin/../conf/zoo.cfg ]; then
      echo 'zoo.cfg not found, create from sample.cfg'
      cp $zkbin/../conf/zoo_sample.cfg $zkbin/../conf/zoo.cfg
    fi
    #echo 'starting zookeeper service...'
    $zkbin/zkServer.sh start
  fi
  ;;

(stop)
  #stop zk service
  if [ "$SINGA_MANAGES_ZK" = "true" ]; then
    #echo 'stopping zookeeper service...'
    $zkbin/zkServer.sh stop
  fi
  ;;

esac

