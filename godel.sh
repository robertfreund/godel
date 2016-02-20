#!/usr/bin/env bash

#########################################
#
# Script to remove the source files and artifacts produced by `go get [importpath]`
#
# usage: godel [import path]
#
#		ex. ./godel github.com/my/pkg/to/delete
#
#########################################

IMPORT_PATH=${1:-help}
if [[ $IMPORT_PATH == *'help'* ]]
then
    echo " Usage: godel [import path]"
    echo " Example to delete : godel github.com/my/pkg/to/delete"
    echo " ---------"
else
    go clean -i -n ${IMPORT_PATH}
    go clean -i ${IMPORT_PATH}

    PACKAGE_PATH=${GOPATH}/pkg/darwin_amd64/${IMPORT_PATH}
    PACKAGE_CMD="rm -rf $PACKAGE_PATH"
    echo "Removing package directory: $PACKAGE_PATH"
    echo "$PACKAGE_CMD"
    eval $PACKAGE_CMD

    SRC_PATH=${GOPATH}/src/${IMPORT_PATH}
    echo "Removing source directory: $SRC_PATH"
    REM_CMD="rm -rf $SRC_PATH"
     echo "$REM_CMD"
    eval $REM_CMD
fi