#/bin/bash
#to submit repository to remote
username=""
token=""
branch=""
comment="new pthiroject"
explain_command(){
    while getopts ":c:" opt; do
        case $opt in
            c) 
            comment="$OPTARG"
            echo "|-> Set comment ${comment}"
            ;;
            \?) 
            echo "|-> Unexpected command option"
            echo "|-> git_push [-c comment]"
            exit
            ;;
        esac
    done
}
username=`sed -n 1p .W_GITPUSH_TOKEN | tr -d "\n"`
token=`sed -n 2p .W_GITPUSH_TOKEN | tr -d "\n"`
echo "|-> Username $username"
repo_name=`basename $(pwd) | tr -d "\n" `
echo "|-> Repository $repo_name"
explain_command
#try to get the remote respository
status_code=$(curl -k -I -s -o /dev/null -w "%{http_code}" "https://github.com/$username/$repo_name")
if [ -d ".git" ]; then
    if [ "$status_code" -eq 200 ];then
        echo "|-> Found repository $repo_name"
    else
        echo "|-> User $username have no repository named $repo_name,try delete the .git file and run again"
        exit 1
    fi
    echo "|-> Try push start"
    git add . >> gitpushlog
    git commit -m "$comment" >> gitpushlog
    git branch -M $branch >> gitpushlog
    git remote add origin "https://github.com/$username/$repo_name.git" >> gitpushlog
    git push origin main >> gitpushlog
    # 匹配提示输入用户名的文本，并发送用户名
    echo "|-> Examine the username and token"
    expect "Username for '*':"
    send "$username"
    # 匹配提示输入密码的文本，并发送密码
    expect "Password for '*':"
    send "$token"
    echo "|-> Push OK"
else
    echo "|-> This catagory is not a repository,will init it"
    echo "|-> Init it"
    git init >> gitpushlog
    git add . >> gitpushlog
    git commit -m "$comment" >> gitpushlog
    echo "|-> Create it on Github"
    curl -k -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' >> gitpushlog
    echo "|-> Push"
    git branch -M main >> gitpushlog
    git remote add origin "https://github.com/$username/$repo_name.git" >> gitpushlog
    echo "|-> Examine the username and token"
    git push origin main >> gitpushlog
# 执行 git push 操作
spawn git push origin main
# 匹配提示输入用户名的文本，并发送用户名
expect "Username for '*':"
send "username\r"

# 匹配提示输入密码的文本，并发送密码
expect "Password for '*':"
send "$token\r"

expect eof
fi