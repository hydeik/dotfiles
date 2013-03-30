#!/bin/sh

clang -cc1 -std=c++11 -stdlib=libc++ -x c++ stdafx.h -emit-pch -o stdafx.pch
