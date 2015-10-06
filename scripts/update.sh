VM='ubuntu_14.04'
VBoxManage controlvm $VM poweroff
sleep 1
for ii in {1..5}
do
  VBoxManage storageattach $VM --storagectl "SATA Controller" --port $(( ii - 1 )) --device 0 --medium none && \
  VBoxManage closemedium disk gitignore/hdd${ii}.vdi && \
  rm -rvf gitignore/hdd${ii}.vdi && \
  VBoxManage createhd --filename gitignore/hdd${ii}.vdi --size 10000
  VBoxManage storageattach $VM --storagectl "SATA Controller" --port $(( ii - 1 )) --device 0 --type hdd --medium gitignore/hdd${ii}.vdi
done
sleep 1
VBoxManage startvm $VM
sleep 1
VBoxManage storageattach $VM --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ../vagrant/auto.iso
