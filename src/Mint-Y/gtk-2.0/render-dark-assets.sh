#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="assets-dark.svg"
ASSETS_DIR="assets-dark"
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

cp $ASSETS_DIR/button.png menubar-toolbar/button.png
cp $ASSETS_DIR/button-hover.png menubar-toolbar/button-hover.png
cp $ASSETS_DIR/button-active.png menubar-toolbar/button-active.png
cp $ASSETS_DIR/button-insensitive.png menubar-toolbar/button-insensitive.png

cp $ASSETS_DIR/toolbar-entry-border-active-bg.png menubar-toolbar/toolbar-entry-border-active-bg-dark.png
cp $ASSETS_DIR/toolbar-entry-border-bg.png menubar-toolbar/toolbar-entry-border-bg-dark.png
cp $ASSETS_DIR/toolbar-entry-border-disabled-bg.png menubar-toolbar/toolbar-entry-border-disabled-bg-dark.png

cp $ASSETS_DIR/menubar.png menubar-toolbar/menubar-dark.png
cp $ASSETS_DIR/menubar_button.png menubar-toolbar/menubar_button-dark.png

exit 0
