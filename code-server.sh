#!/bin/bash

echo "Installing CODE-SERVER..."
# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Create the service file
cat <<EOT > /etc/systemd/system/code-server.service
[Unit]
Description=code-server
After=network.target

[Service]
User=root
Environment=PASSWORD=1234
ExecStart=/usr/bin/code-server --auth password --bind-addr 0.0.0.0:8118

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd and start code-server
systemctl daemon-reload
systemctl start code-server
systemctl enable code-server
clear
sleep 3
echo "Installation Successful"