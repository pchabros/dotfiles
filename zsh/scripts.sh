#!/bin/zsh

# Compress a directory
compress() {
    tar cvzf $1.tar.gz $1
}

