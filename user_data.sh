#!/bin/bash
set -euo pipefail

apt-get update -y
apt-get install -y openjdk-17-jre-headless curl

useradd -m -r -d /opt/minecraft minecraft
mkdir -p /opt/minecraft/server

cd /opt/minecraft/server
curl -fsSL -o server.jar "${minecraft_server_url}"

cat <<EULA > eula.txt
eula=true
EULA

cat <<PROPS > server.properties
motd=${minecraft_motd}
max-players=${minecraft_max_players}
server-port=${minecraft_port}
enable-query=true
PROPS

chown -R minecraft:minecraft /opt/minecraft

cat <<SERVICE > /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=minecraft
WorkingDirectory=/opt/minecraft/server
ExecStart=/usr/bin/java -Xms${minecraft_xms} -Xmx${minecraft_xmx} -jar server.jar nogui
Restart=on-failure

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable --now minecraft
