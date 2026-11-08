apt-get update
apt-get install -y systemd
apt-get install -y udev
apt-get install -y iputils-ping
apt-get install -y network-manager
apt-get install -y netplan.io
ln -s /lib/systemd/systemd /sbin/init

apt-get install -y gdm3
apt-get install -y ubuntu-desktop

apt-get install -y sudo

mkdir -p /etc/netplan

cat > /etc/netplan/99_config.yaml <<'EOF'
network:
  version: 2
  renderer: networkd
  ethernets:
    enx00e04cd25840:
      dhcp4: true
EOF

sync

