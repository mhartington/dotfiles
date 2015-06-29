#!/bin/sh

echo "This is a quick install for Mikes setup"
echo "This assumes you have Homebrew installed"
echo "And git, node insalled viw brew"

echo "Are you sure you want to continue (y/n)? "  
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo Yes
else
    echo No
fi

exit 0
