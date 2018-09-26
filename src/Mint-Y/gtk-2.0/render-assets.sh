#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="assets.svg"
ASSETS_DIR="assets"
INDEX="assets.txt"

for i in `cat $INDEX`
do 
if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png 
fi
done

cp $ASSETS_DIR/toolbar-entry-border-active-bg.png menubar-toolbar/toolbar-entry-border-active-bg.png
cp $ASSETS_DIR/toolbar-entry-border-bg.png menubar-toolbar/toolbar-entry-border-bg.png
cp $ASSETS_DIR/toolbar-entry-border-disabled-bg.png menubar-toolbar/toolbar-entry-border-disabled-bg.png

cp $ASSETS_DIR/menubar.png menubar-toolbar/menubar.png
cp $ASSETS_DIR/menubar_button.png menubar-toolbar/menubar_button.png

exit 0
