#!/bin/bash

find -type f -name *.css -exec cat {} \; | ./modMintYcolors.py >> 1-change-color.sh
find -type f -name *.svg -exec cat {} \; | ./modMintYcolors.py >> 1-change-color.sh
