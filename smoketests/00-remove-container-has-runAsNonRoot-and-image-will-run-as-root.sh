kubectl create clusterrolebinding privileged-cluster-role-binding \
    --clusterrole=vmware-system-tmc-psp-privileged \
    --group=system:authenticated
