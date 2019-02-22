# YAML in K8s

Every k8s config files contains the following top level or root level properties:

- apiVersion
- kind
- metadata
- spec


# Networking

Unlike in the docker world where an IP address is always assigned to a docker container
in the kubernetes world the IP address is assigned to a Pod, each Pod in the kubernetes
gets its own internal IP address.

When Kubernetes is initially configured we create an internal private network with the
address e.g. 10.244.0.0 and all the pods are attached to it.
When you deploy multiple pods they all get a separate IP assigned from this network.

Kubernetes does not automatically setup any kind of networking to handle these issues.
Kubernetes expects us to set up networking to meet certain fundamental requirements:

- All the containers/pods in a Kubernetes cluster must be able to communicate with one
  another without having to configure NAT.
- All nodes must be able to communicate with containers and all containers must be able
  to communicate with the nodes in the cluster.

Kubernetes expects us to set up a networking solution that meets these criteria.


# Services

For example our application has groups of pods running various sections such as a group
for serving our frontend, load to users and other group for running backend processes
and a third group connecting to an external data source.

It is services that enable connectivity between these groups of pods. Services enable
the frontend application to be made available to end users.

It helps communication between back end and front end pods and helps in establishing
connectivity to an external data source.

Thus services enable loose coupling between micro services in our application.


Kubernetes service is an object just like pods, replica set or deployments. One of its
use case is to listen to a port on the node and forward request on that port to a port
on the pod.
This type of service is known as a NodePort service because the service listens to port
on the node and forward requests to the pods.

For a list of services see: https://kubernetes.io/docs/concepts/services-networking/service/

1. TargetPort - port on the pod
2. Port - port on the service
3. NodePort - port on the node (range 30000-32767)


## LoadBalancer

**A LoadBalancer service is the standard way to expose a service to the internet.**
On GKE, this will spin up a Network Load Balancer that will give you a single IP
address that will forward all traffic to your service.

### When would you use this?
If you want to directly expose a service, this is the default method. All traffic on
the port you specify will be forwarded to the service. There is no filtering, no
routing, etc. This means you can send almost any kind of traffic to it, like HTTP, TCP,
UDP, Websockets, gRPC, or whatever.

_The big downside is that each service you expose with a LoadBalancer will get its own
IP address, and you have to pay for a LoadBalancer per exposed service, which can get
expensive!_

Ref: [Kubernetes NodePort vs LoadBalancer vs Ingress?](https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0)


# Misc
`minikube` is a single node k8s cluster that we run locally - for testing purposes
`kubeadm` (pronunced kubeadmin) is a multi node setup on your local machine


# Rollout

Check for status
```
$ kubectl rollout status deployment/myapp-deployment
```

Check for history
```
$ kubectl rollout history deployment/myapp-deployment
```


There are 2 types of deployment strategies.

1. Destroy all old ones and create new ones (Recreate strategy)
2. Take down older versions one by one (Rolling update - default)


Deploy with the apply command
```
$ kubectl apply -f deployment-definition.yaml
```

If you broke the production you can rollback with the following command

```
$ kubectl rollout undo deployment/myapp-deployment
```

This will destroy the pods in the new replica sets and bring up the older pods in the
old replica sets.
