```bash
KUBECTL_COMMAND="${1}"
NAMESPACE="${2}"

kubectl "${KUBECTL_COMMAND}" -f - <<EndOfMessage
apiVersion: v1
kind: ServiceAccount
metadata:
  name: debug
  namespace: "${NAMESPACE}"
---
apiVersion: v1
kind: Pod
metadata:
  name: debug
  namespace: "${NAMESPACE}"
spec:
  terminationGracePeriodSeconds: 1
  serviceAccountName: debug
  securityContext:
    runAsNonRoot: false
    runAsUser: 0
    runAsGroup: 0
    fsGroup: 0
  containers:
    - name: debug
      image: seemscloud/debug:latest
      imagePullPolicy: Always
      securityContext:
        runAsNonRoot: false
        runAsUser: 0
        runAsGroup: 0
        allowPrivilegeEscalation: true
        privileged: true
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: debug
rules:
  - apiGroups: [ "*" ]
    resources: [ "*" ]
    verbs: [ "*" ]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: debug
subjects:
  - kind: ServiceAccount
    name: debug
    namespace: default
roleRef:
  kind: ClusterRole
  name: debug
  apiGroup: rbac.authorization.k8s.io
EndOfMessage
```