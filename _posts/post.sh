#! /bin/sh

usage()
{
    echo "post [-hac]"
}

#
# S1: file
# $2: content
create()
{
    echo "---
layout: post
title: 
categories: 
tags: 
author: Jacob Pan
date: $date
---

* content
{:toc}


$2


> Jacob Pan [( jacobpan3g.github.io/cn )](http://jacobpan3g.github.io/cn)
" > $1
}

##### upgrade
date=`date +%Y-%m-%d`

##### routine
routine_content="## $date Monday
## $date Tuesday
## $date Webnesday
## $date Thursday
## $date Friday
## $date Saturday
## $date Sunday"


while getopts "hac:u:r:" opt
do
    case $opt in
        h) usage;;
        a) find . -name "*.md";;
        c) create $OPTARG;;
        u) sed -i "/^date: 20/c date: $date" $OPTARG;;
        r) create $OPTARG "$routine_content";;
        ?) echo "invalid option";;
    esac
    shift
done
#shift $(($OPTIND - 1)) 

