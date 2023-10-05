kubectl delete secret azure-registry  
kubectl delete secret dockhub-registry  
kubectl create secret docker-registry azure-registry     --docker-server=akseutap6registry.azurecr.io --docker-username=87d50e13-00aa-48a2-b6b3-91ba311b743e --docker-password=2tJ8Q~p4cjicS-BpaXm3AWi8m49R19.m.jw4ZcvY
kubectl create secret docker-registry dockhub-registry   --docker-server=docker.io  --docker-username=bmoussaud --docker-password=dckr_pat__VTi8momb9S8D2GafrgY-n2YFlM
