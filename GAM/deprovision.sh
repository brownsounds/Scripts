#!/bin/bash
#Utility to remove user from all google groups

#define gam function

gam()
{
	python ~/gam/src/gam.py
}
export -f gam

username="$1"
manager="$2"
read -r -p "Are you sure you want to remove $1 from all mail groups? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo "Okay"
	rm /tmp/groups.tmp
	number_of_groups="$(gam info user $username | grep "Groups: (" | sed 's/[^0-9]//g')"
	gam info user $username | grep -A $number_of_groups Groups | grep -v Groups | sed 's/^[^<]*<//g' | sed 's/\@.*$//g' > /tmp/groups.tmp
	while read in; do gam update group "$in" remove user $username && echo $username 'is removed from' $in; done < /tmp/groups.tmp
	rm /tmp/groups.tmp
fi

gam update user $username password random
echo "Password changed to random"

echo "Deprovisioning " $username
gam user $username deprovision
