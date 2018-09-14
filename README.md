This repo contains some scripts to test the state of the networking connectivity in a Kubernetes cluster.

It installs 2 daemonsets, one on the pod network and one on the host network. It then attempts to check both 
the connectivity between all pods (host-\>host, pod-\>pod, host-\>pod, pod-\>host), and also that 
the Kube-Proxy/Kube-DNS layer is working as expected too.

To install into a cluster:

```
make apply
```

To delete:

```
make delete
```

The checks are performed in a loop every 30 seconds.
Any errors will cause the pods to fail. These will then be restarted by the daemonset, thus
a non-zero value of pod restarts indicates failures are occuring.
