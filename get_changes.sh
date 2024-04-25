read -p "Enter branch name to pull from tm-givsum repo:" tm_branchname
if [ ! -z "$tm_branchname" ]
then
	cd /home/tejasambalia/Documents/GitHub/tm-givsum
	checkout_output=$(git checkout $tm_branchname)
	if [[ $checkout_output == *"error"* ]]; then
		echo "$checkout_output"
	else
		git pull
		cd /home/tejasambalia/Documents/GitHub-master/givsum
		check_live_branch=$(git branch -a | grep -i $tm_branchname)
		if [ -z "$check_live_branch" ]
		then
			echo "IF"
			git checkout -b $tm_branchname main
		else
			echo "ELSE"
			git checkout $tm_branchname
			git pull
		fi
		cp -a /home/tejasambalia/Documents/GitHub/tm-givsum/app/. /home/tejasambalia/Documents/GitHub-master/givsum/app
		cp -a /home/tejasambalia/Documents/GitHub/tm-givsum/db/. /home/tejasambalia/Documents/GitHub-master/givsum/db
		cp -a /home/tejasambalia/Documents/GitHub/tm-givsum/config/. /home/tejasambalia/Documents/GitHub-master/givsum/config
	fi
	# git branch --all | grep -i $tm_branchname >> /home/tejasambalia/Documents/automation/outpui.txt
else
	echo "Please re-run script and enter branch name"
fi