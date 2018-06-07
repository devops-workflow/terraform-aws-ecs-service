###
### Mount EFS volumes
###
# Can switch to using AWS' EFS helper
#   yum -y install amazon-efs-utils
#   mount -t efs
#   fstab: efs defaults,_netdev 0 0
#   mount -a -t efs
# Look at https://docs.aws.amazon.com/efs/latest/ug/troubleshooting-efs-mounting.html#automount-fails
#   if have issues with multiple EFS mounts at boot time

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
  echo -e "$${host}:/ $${mountBase}/$${mount} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" >> /etc/fstab
done
# If EFS was just created, it may not be ready yet. Can take up to 90 seconds
# how to test? Or loop till mounted with 90 second timeout?
# mount
mount -a -t nfs4
