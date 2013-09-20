#!/bin/sh

#  script.sh
#  Librelio
#
#  Copyright (c) 2013 WidgetAvenue - Librelio. All rights reserved.

PATH_TO_SOURCE=$(<"${SRCROOT}/ScriptTarget/path.txt")

#Compile xibs
for f in $(find "$PATH_TO_SOURCE" -type f -name "*.xib")
do
echo "Processing $f"
filename=$(basename "$f")
extension="${filename##*.}"
filename="${filename%.*}"
ibtool "$f" --compile "$filename.nib"
done


#Copy all resources
find -L "$PATH_TO_SOURCE" \
-type f -not -name ".*" \
-not -name "`basename ${INFOPLIST_FILE}`" \
| xargs -t -I {} \
cp {} ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/