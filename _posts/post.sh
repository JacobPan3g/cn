#! /bin/sh

usage()
{
    echo "post [-hac]"
}

create()
{
    echo "---
layout: post
title: 
categories: 
tags: 
author: Jacob Pan
---

* content
{:toc}



> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
" > $1
}

while getopts "hac:" opt
do
    case $opt in
        h) usage;;
        a) find . -name "*.md";;
        c) create $OPTARG;;
        ?) echo "invalid option";;
    esac
    shift
done
#shift $(($OPTIND - 1)) 


