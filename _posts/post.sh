#! /bin/sh

date="date: `date +%Y-%m-%d`"

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
$date
---

* content
{:toc}



> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
" > $1
}

while getopts "hac:u:" opt
do
    case $opt in
        h) usage;;
        a) find . -name "*.md";;
        c) create $OPTARG;;
        u) sed -i "/^date: 20/c $date" $OPTARG;;
        ?) echo "invalid option";;
    esac
    shift
done
#shift $(($OPTIND - 1)) 


