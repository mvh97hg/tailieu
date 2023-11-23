#!/bin/bash

if ! command -v yq &> /dev/null; then
    echo "Cài đặt yq..."
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && chmod +x /usr/local/bin/yq
    
else
    echo "yq đã được cài đặt."
fi


##Script kiểm tra và update `/scripts/update_teleport.sh`

mkdir -p /scripts
cat <'EOF'> /scripts/update_teleport.sh
#!/bin/bash

# Lấy thông tin phiên bản từ máy chủ
PROXY=$(cat /etc/teleport.yaml | yq '.teleport | .auth_servers[0] // .proxy_server')
VERSION=$(curl -s https://${PROXY}/webapi/ping | yq -r .server_version)

# Lấy phiên bản hiện tại
LOCAL_VERSION=$(teleport version | awk '{print $2}' | cut -d'v' -f2)

# So sánh phiên bản
if [[ $LOCAL_VERSION < $VERSION ]]; then
    echo "Phiên bản hiện tại ($LOCAL_VERSION) nhỏ hơn phiên bản của máy chủ ($VERSION). Đang tiến hành cập nhật..."
    
    ## update trên centos 7
    yum update teleport -y

    ## update trên debian/ubuntu

    #apt-get update 2>&1 > /dev/null
    #apt --only-upgrade install -y teleport=${VERSION}

    systemctl restart teleport

    echo "Cập nhật hoàn tất."
else
   echo "Phiên bản hiện tại ($LOCAL_VERSION) không cần cập nhật."

fi
EOF

chmod +x /scripts/update_teleport.sh

## Dat crontad

if ! crontab -l &> /dev/null; then
    (echo "0 1 * * * /scripts/update_teleport.sh > /dev/null 2>&1") | crontab -
    
else
    # Check if the cron job already exists
    if ! crontab -l | grep -q "/scripts/update_teleport.sh"; then

        (crontab -l ; echo "0 1 * * * /scripts/update_teleport.sh > /dev/null 2>&1") | crontab -
    else
        echo "Cron job đã tồn tại."
    fi
fi