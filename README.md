# HelloNode

## HelloNode example for minikube

### Install and start Minikube

Install for MacOSX
```
brew cask install minikube
brew install kubectl
```
or using
```
# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl

# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
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
docker build -t hellonode:1.0.0 .
docker images
```

Create a new deployment
```
kubectl run hello-node --image=hellonode:1.0.0 --port=8080
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

Now using helm
```
helm install ./config/charts/hellonode
```

Overidding a value:
```
helm install ./config/charts/hellonode --set "image.tag=$(cat VERSION)"
or
make deploy
```

Generate with kite :
```
kite generate service --git git@github.com:helios-technologies/hellonode.git --image hellonode  --image-version=1.0.0 --chart-version=0.1.0 .
```
