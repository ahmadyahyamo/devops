### Kubernetes installation

### Nodes on azure
    one master node 10.1.1.4
    one worker node 10.1.1.5

### Configure nodes
    sudo swapoff -a

### Install K8s
    run ./containerd.sh
    run ./kubernetes.sh

### Initialize K8s cluster on master node
    sudo kubeadm init


### Access cluster as admin
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

### download the manifest for weave
    wget "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" -O "weave.yaml"

### Install weave network plugin
    kubectl apply -f weave.yaml

### check weave net status
    kubectl exec -n kube-system weave-net-1jkl6 -c weave -- /home/weave/weave --local status

### Join worker node
    kubeadm join 10.1.1.4:6443 --token 8brkyl.yiaj2rfpw5bawsrx --discovery-token-ca-cert-hash sha256:3de6a8a34869224d2cbcfade29fa1bfe06a3c4f9f9c53066414cb0daab21d6d5

### Install helm
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm

### Install ingress-nginx controller
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo update
    helm install ingress-nginx ingress-nginx/ingress-nginx

### Create namespace
    kubectl apply -f ns.yml

### Create juice-shop deployment and internal service
    kubectl apply -f juice-shop-deployment-svc.yml

### Create juice-shop ingress
    kubectl apply -f juice-shop-ingress.yml