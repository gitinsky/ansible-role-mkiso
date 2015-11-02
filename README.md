# mksio role

Role is designed to add preseed options to ISO images. These options are based on ansible inventory groups and variables. Set ```mkiso_group``` variable to the name of the target group. Ensure to set ```host_presets``` variable, use ```vagrant/host_vars/vm1.vagrant.yml``` as an example.

## Warning!
Role is currently in depelopment. Some major settings (like disk setup) are still hardcoded in the templates. It is tuned to set up raid 10 and lvm on 5 disks. Feel free to make pull requests with parametrized disk setup.

# Known issues confirmed on ubuntu 14.04.3 server iso

- Initial user setup doesn't work for some reason. We are fine due to valid ssh access and no-passwords user. Not sure if it's a configuration or installer issue.
- Hotspare raid parameter is ignored by the installer.
- Multiple LVMs require propper naming. Post installation renaming has to be implemented in this role. See example.preseed for some details.
- ```combine``` filter is avaliable starting from ansible 2.0 so ```host_presets``` has to be fully declared on host or group basis. Merging is going to be implemented after ansible 2.0 release. In fact I'm going to declare 4 dictionaries: host_presets, host_presets_encrypted, group_presets, group_presets_encrypted.
- On some systems ```sda``` disk is not avaliable during installation. That is caused by late driver loading and ```sdb``` has to be used as a first drive. ```ls``` still shows ```/dev/sda``` but ```cat``` and ```dd``` commands fail to operate with it and installation fails with ```sda``` errors.

# Template debugging

Run role with debug tag and varialbe:

```bash
ansible-playbook mkiso.yml -t debug -e debug=yes
```

And find you preseed files locally in /ymp/mkiso directory.

# ISO testing

See ```scripts``` for some virtual box automation scripts.

# Reference
## Ubuntu preseed
http://searchitchannel.techtarget.com/feature/Performing-an-automated-Ubuntu-install-using-preseeding
https://help.ubuntu.com/lts/installation-guide/example-preseed.txt
https://wikitech.wikimedia.org/wiki/PartMan
https://wiki.ubuntu.com/Enterprise/WorkstationAutoinstallPreseed

http://ubuntuforums.org/showthread.php?t=1504045
http://askubuntu.com/questions/573108/how-to-configure-raid-2-lvm-volumes-via-preseed
https://github.com/ahamilton55/Blog-Scripts/blob/master/debian_ubuntu_preseeds/ubuntu-raid1-lvm.preseed
http://serverfault.com/questions/541117/12-04-preseeded-install-with-raid-and-lvm
http://bryars.eu/2011/08/automating-debian-preseed-installs-with-raid-and-lvm/


## virtual box
http://www.howopensource.com/2011/06/how-to-use-virtualbox-in-terminal-commandline/
http://nakkaya.com/2012/08/30/create-manage-virtualBox-vms-from-the-command-line/
