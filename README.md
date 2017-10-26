# HelloNode
## HelloNode example for Google Container Engine (GCE)

### Install gcloud SDK

Install for Linux
```
read https://cloud.google.com/sdk/
```

Run minikube and set kubeconfig
```
gcloud login
gcloud container clusters
```

Test if the connection to the cluster works
```
kubectl get nodes
```

### Git clone this repository and build image

```
git clone https://github.com/helios-technologies/hellonode.git
cd hellonode
```

build the docker image into the minikube engine
```
docker build -t gcr.io/helios-devel/hellonode:0.1.0 .
docker images
# or use make
```

Push to container in GCR
```
gcloud docker -- push gcr.io/helios-devel/hellonode:0.1.0
```

Create a new deployment
```
kubectl run hello-node --image=gcr.io/helios-devel/hellonode:0.1.0 --port=8080
```

List all resources
```
kubectl get all
```

Expose locally the service using a proxy tunnel
```
kubectl port-forward hello-node 8080:8080
```

Curl your service
```
curl http://localhost:8080/
```


## HelloNode example for minikube

### Install and start Minikube

Install for MacOSX
```
brew cask install minikube
brew install kubectl
```

Run minikube and set kubeconfig
```
minikube start
kubectl config use-context minikube
```

Configure your docker client to point into minikube docker engine
```
eval $(minikube docker-env)
```

### Git clone this repository and build image

```
git clone https://github.com/helios-technologies/hellonode.git
cd hellonode
```

build the docker image into the minikube engine
```
docker build -t hellonode:1.0 .
docker images
```

Create a new deployment
```
kubectl run hello-node --image=hellonode:1.0 --port=8080
```

Expose the service onto a VM port
```
kubectl expose deployment hello-node --type=NodePort
```

List all resources and curl your service
```
kubectl get all
curl $(minikube service hello-node --url)
```
