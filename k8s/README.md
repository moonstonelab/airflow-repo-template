# Installing custom airflow image to k8s

## Pre-requisites

- kind: https://airflow.apache.org/docs/helm-chart/stable/quick-start.html
- kubetrl: https://kubernetes.io/docs/tasks/tools/#kubectl
- kustomize: https://kubectl.docs.kubernetes.io/installation/kustomize/
- helm: https://helm.sh/docs/intro/install/

## Install & upgrade

The installation and upgrading processes are scripted in `Makefile`

```bash
# For install
make local_install

# For upgrading
make local_upgrade

# Uninstallation
make uninstall
```