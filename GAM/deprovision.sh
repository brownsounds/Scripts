#!/bin/bash
#Utility to remove user from all google groups

#define gam function


username="$1"
manager="$2"
read -r -p "Are you sure you want to remove $1 from all mail groups? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo -e "$(tput setaf 3)Parsing group membership$(tput sgr0)"
	rm /tmp/groups.tmp &>/dev/null
	number_of_groups="$(python ~/gam/src/gam.py info user $username | grep "Groups: (" | sed 's/[^0-9]//g')"
	python ~/gam/src/gam.py info user $username | grep -A $number_of_groups Groups | grep -v Groups | sed 's/^[^<]*<//g' | sed 's/\@.*$//g' > /tmp/groups.tmp
	while read in; do python ~/gam/src/gam.py update group "$in" remove user $username && echo $username 'is removed from' $in; done < /tmp/groups.tmp
	rm /tmp/groups.tmp
fi

python ~/gam/src/gam.py update user $username password random
echo -e "$(tput setaf 3)Password changed to random$(tput sgr0)"

echo -e "$(tput setaf 3)Deprovisioning " $username $(tput sgr0)
python ~/gam/src/gam.py user $username deprovision

#disable POP/IMAP forwarding
python ~/gam/src/gam.py user $username pop off
python ~/gam/src/gam.py user $username imap off
python ~/gam/src/gam.py user $username delegate to $manager