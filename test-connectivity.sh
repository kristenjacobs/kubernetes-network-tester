# Installs kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.9.1/bin/linux/amd64/kubectl >& /dev/null
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

function ping_ips() {
    local service_name=$1 
    echo "++++++++ Testing $service_name ++++++++"
    ips=$(kubectl get endpoints "$service_name" -o jsonpath='{.subsets[*].addresses[*].ip}')
    for ip in $ips; 
    do 
        ip=$(echo "$ip" | tr -d '"')
        ping -c 1 "$ip" > /dev/null
        if [ $? -ne 0 ]
        then
            echo "ERROR: ********** ping $ip failed **********"
            exit 1
        fi  
        echo "$(date): $ip - OK"
    done
}

while true
do 
    ping_ips "host-network"
    ping_ips "pod-network"
    sleep 30
done
