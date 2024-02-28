#/bin/bash
response=$(curl -I -s -o /dev/null -w "%{http_code}" "https://github.com/W1412X/test1619")
if [ $? -eq 0 ];then
    if echo "$response" | grep -q '"id"'; then
        echo "OK"
    else
        echo "Error: Failed to create repository. Response: $response"
    fi
else
    echo "Error: Curl command failed. Response: $response"
fi