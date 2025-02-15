# Download Ubuntu 24.04 Cloud Image
wget -O /var/lib/vz/template/iso/ubuntu-24.04-server-cloudimg-amd64.img \
    https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img

# Create VM template
VMID=1000
qm create $VMID --name "ubuntu-24-cloud" --memory 4096 --cores 2 --net0 virtio,bridge=vmbr2
qm importdisk $VMID /mnt/pve/cephfs/template/iso/ubuntu-24.04-server-cloudimg-amd64.img local-lvm
qm set $VMID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$VMID-disk-0
qm set $VMID --ide2 local-lvm:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --agent 1
qm set $VMID --sshkey ~/.ssh/id_rsa.pub
qm template $VMID




# Create a new VM with ID 9000
VMID=101
qm create $VMID --name "ubuntu-24-cloud" --memory 4096 --cores 2 --net0 virtio,bridge=vmbr0



systemctl enable rke2-agent.service



echo "server: https://rke2-node1:9345" | sudo tee /etc/rancher/rke2/config.yaml
echo "token: K10a69784c82c310c179e6e485baff1b3320f5e5b00d830bb170428b566e225acfc::server:6783844c7f1990e8c35ad1e6108a0e18" | sudo tee -a /etc/rancher/rke2/config.yaml


