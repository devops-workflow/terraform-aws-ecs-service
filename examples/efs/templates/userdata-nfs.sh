###
### Mount EFS volumes
###
# Can switch to using AWS' EFS helper
#

# mounts is a list of "host:service"
if ! rpm -qa | grep -qw nfs-utils; then
    yum -y install nfs-utils
fi

# Create mount points
mountBase=/mnt/efs
mkdir -p $${mountBase}
cd $${mountBase}
for d in ${mounts}; do
  dir=$(echo $d | cut -d: -f2)
  mkdir -p $${dir}
  chmod 0000 $${dir}
done
### Setup fstab
# Backup fstab
cp -p /etc/fstab /etc/fstab.$(date +%F)
for m in ${mounts}; do
  host=$(echo $m | cut -d: -f1)
  mount=$(echo $m | cut -d: -f2)
  echo -e "$${host}:/ $${mountBase}/$${mount} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab
done
# mount
mount -a
