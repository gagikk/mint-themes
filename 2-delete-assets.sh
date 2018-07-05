#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Deleting all assets i.e. png in the src folder"

find src/Mint-Y/gtk-{2,3}.0 -name "*.png" -exec rm -v {} \;
git checkout -- src/Mint-Y/gtk-3.0/thumbnail.png
git checkout -- src/Mint-Y/gtk-3.0/thumbnail-dark.png
git checkout -- src/Mint-Y/gtk-3.0/assets/thumbnail-frame.png

find . -name "*.png" -type f -exec convert {} -modulate "100,100,165" {} \;

echo "All png's have been deleted"
echo "Proceed to making the assets."
echo
echo "Run script number 3 to make the assets."
