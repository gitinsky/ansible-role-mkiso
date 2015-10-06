VM='ubuntu_14.04'
VBoxManage controlvm $VM poweroff
sleep 1
for ii in {1..5}
do
  VBoxManage storageattach $VM --storagectl "SATA Controller" --port $(( ii - 1 )) --device 0 --medium none && \
  VBoxManage closemedium disk gitignore/hdd${ii}.vdi && \
  rm -rvf gitignore/hdd${ii}.vdi
done
sleep 1
VBoxManage unregistervm $VM --delete
