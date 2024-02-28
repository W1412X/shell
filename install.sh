#/bin/bash
echo "|-> Config git"
git config 
read -p "Enter the Github Username:" username
read -p "Enter the token you get:" token
echo "$username" > ./.W_GITPUSH_TOKEN
echo "$token" >> ./.W_GITPUSH_TOKEN
sudo cp ./.W_GITPUSH_TOKEN ~/.W_GITPUSH_TOKEN
sudo cp ./git_push.sh /usr/bin/git_push
sudo chmod +x /usr/bin/git_push
read -p "Enter the Github Usermail:" usermail 
git config --global user.email "$usermail"
git config --global user.name "$username"