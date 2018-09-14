# Installs netcat
yum install -y nc

function test_connection() {
    local service_fqdn=$1
    nc -z $service_fqdn 5555
    if [ $? -ne 0 ]
    then
        echo "ERROR: ********** connection to $service_fqdn failed **********"
        exit 1
    fi  
    echo "$(date): $service_fqdn - OK"
}

# Have a little snooze while we wait for the netcat servers in all the pods to start.
sleep 30

while true
do 
    # Checks that we can connect to the pods via the headless service (direct to pods)
    # (i.e. validate that kube-dns is working)
    test_connection host-network-headless.default.svc.cluster.local
    test_connection pod-network-headless.default.svc.cluster.local
    
    # Checks that we can connect to the pods via the service (ClusterIP)
    # (i.e. validates that kube-proxy is working)
    test_connection host-network.default.svc.cluster.local
    test_connection pod-network.default.svc.cluster.local

    sleep 30
done
