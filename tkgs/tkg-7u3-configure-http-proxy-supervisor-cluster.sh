#https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-0A219D97-0636-4337-9603-93FB1312AD42.html#using-the-cluster-management-api-to-configure-http-proxy-on-supervisor-clusters-4
set -x 
vc_address="10.214.182.33"
cluster_id="domain-c8"
username="administrator@vsphere.local"
password="xxxxxxxxxRGd"

session_id=$(curl -ksX POST --user "${username}:${password}" https://${vc_address}/api/session | xargs -t)
echo "SESSION ID is ${session_id}"
echo "CLUSTER URL  https://${vc_address}/api/vcenter/namespace-management/clusters/${cluster_id}"
echo "Initial state"
curl -k -X GET -H "vmware-api-session-id: ${session_id}" https://${vc_address}/api/vcenter/namespace-management/clusters/${cluster_id} | jq


curl -k -X PATCH -H "vmware-api-session-id: ${session_id}" -H "Content-Type: application/json" -d '{ "cluster_proxy_config": { "proxy_settings_source": "CLUSTER_CONFIGURED", "http_proxy_config":"http://myproxy.svc:1234" } }' https://${vc_address}/api/vcenter/namespace-management/clusters/${cluster_id}
echo "New state"
curl -k -X GET -H "vmware-api-session-id: ${session_id}" https://${vc_address}/api/vcenter/namespace-management/clusters/${cluster_id} | jq

