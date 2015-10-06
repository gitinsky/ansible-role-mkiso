VM='ubuntu_14.04'
mkdir -vp gitignore
VBoxManage createvm --name $VM --ostype "Ubuntu_64" --register
sleep 1
VBoxManage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
sleep 1
for ii in {1..5}
do
  VBoxManage createhd --filename gitignore/hdd${ii}.vdi --size 5000
done

for ii in {1..5}
do
  echo VBoxManage storageattach $VM --storagectl "SATA Controller" --port $(( ii - 1 )) --device 0 --type hdd --medium gitignore/hdd${ii}.vdi
       VBoxManage storageattach $VM --storagectl "SATA Controller" --port $(( ii - 1 )) --device 0 --type hdd --medium gitignore/hdd${ii}.vdi
done

VBoxManage storagectl $VM --name "IDE Controller" --add ide
VBoxManage storageattach $VM --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ../vagrant/ubuntu-14.04.3-server-amd64.iso

# VBoxManage modifyvm $VM --boot1 disk --boot2 none  --boot3 none --boot4 none
sleep 1

# VBoxManage modifyvm $VM --vram 10
# VBoxManage modifyvm $VM --memory 292
VBoxManage modifyvm $VM --memory 2048
# VBoxManage modifyvm $VM --nic2 bridged --bridgeadapter2 e1000g0 --bridgeadapter2 vnic1 --cableconnected2 on
VBoxManage modifyvm $VM --nic2 hostonly --hostonlyadapter2 vboxnet3 --cableconnected2 on
# # VBoxManage modifyvm $VM --uart1 0x3F8 4 --uartmode1 file "/tmp/$VM.console"
# VBoxManage modifyvm $VM --uart1 0x3F8 4 --uartmode1 server "/tmp/$VM.console"
# sleep 1
VBoxManage startvm $VM
