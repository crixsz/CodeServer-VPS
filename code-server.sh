#!/bin/bash

installer() {
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
Environment=PASSWORD=zoxxenon
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
}

if [ -f /etc/systemd/system/code-server.service ]; then
    echo "Uninstalling CODE-SERVER..."

    # Stop and disable code-server service
    systemctl stop code-server
    systemctl disable code-server

    # Remove the service file
    rm -f /etc/systemd/system/code-server.service

    # Check if code-server is running and kill it
    if pgrep code-server &>/dev/null; then
        pkill code-server
    fi

    clear
    echo "Uninstalled Code-Server"
else
    echo "Code-Server is not installed. Installing..."
    installer
fi
