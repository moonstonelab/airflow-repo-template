VERSION ?= v0.1.0
AIRFLOW_VERSION ?= 2.9.3
NAMESPACE ?= my-airflow
RELEASE_NAME ?= ${NAMESPACE}-release
IMAGE_NAME ?= my-airflow

create_namespace:
	@echo "creating namespace"
	kubectl get namespaces ${NAMESPACE} || kubectl create namespace ${NAMESPACE}

render_templates:
	@echo "Rendering helm chart templates"
	@IMAGE_NAME=${IMAGE_NAME} VERSION=${VERSION} envsubst < ./helm/dev/values.yaml.template > ./helm/dev/values.yaml
	@echo "Rendering kustomize template"
	@NAMESPACE=${NAMESPACE} envsubst < ./kustomize/base/kustomization.yaml.template > ./kustomize/base/kustomization.yaml
	@NAMESPACE=${NAMESPACE} envsubst < ./kustomize/overlays/dev/kustomization.yaml.template > ./kustomize/overlays/dev/kustomization.yaml
	@RELEASE_NAME=${RELEASE_NAME} envsubst < ./kustomize/base/configmap.yaml.template > ./kustomize/base/configmap.yaml
	@RELEASE_NAME=${RELEASE_NAME} envsubst < ./kustomize/overlays/dev/configmap_patch.yaml.template > ./kustomize/overlays/dev/configmap_patch.yaml

local_tag_build: render_templates
	@echo "building image"
	docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${VERSION}

load_to_kind: local_tag_build
	@echo "loading image to kind"
	kind load docker-image ${IMAGE_NAME}:${VERSION}

local_configmap: render_templates
	@echo "creating configmap"
	kustomize build ./kustomize/overlays/dev | kubectl apply -f -

local_install: create_namespace local_configmap load_to_kind
	@echo "installing airflow using helm chart"
	helm install --debug ${RELEASE_NAME} apache-airflow/airflow --namespace ${NAMESPACE} \
	-f ./helm/dev/values.yaml

local_upgrade: create_namespace local_configmap load_to_kind
	@echo "upgrading airflow using helm chart"
	helm upgrade --debug ${RELEASE_NAME} apache-airflow/airflow --namespace ${NAMESPACE} \
	-f ./helm/dev/values.yaml

uninstall:
	helm uninstall ${RELEASE_NAME} --namespace ${NAMESPACE}
	kubectl delete namespace ${NAMESPACE}

port_forward:
	kubectl port-forward --namespace ${NAMESPACE} svc/${RELEASE_NAME}-webserver 8080:8080

viz_local:
	make -Bnd local_install local_upgrade uninstall | make2graph | dot -Tpng -o make.png