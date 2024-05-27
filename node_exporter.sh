#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz
tar xvf node_exporter-1.8.0.linux-amd64.tar.gz
mv node_exporter-1.8.0.linux-amd64/node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-1.8.0.linux-amd64*
useradd --no-create-home --shell /bin/false node_exporter


cat > /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter.service
systemctl enable node_exporter.service
if type firewall-cmd &> /dev/null; then

    firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="103.213.219.200" port protocol="tcp" port="9100" accept'
    firewall-cmd --reload
fi

if type ufw &> /dev/null; then
    ufw allow from 103.213.219.200 to any port 9100
    ufw reload
fi
