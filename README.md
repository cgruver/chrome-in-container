# Run Local Chrome Browser in Workspace

__Note:__ You will need `cluster-admin` privileges, or be granted access to the `etc-pki-entitlement` Secret by a `cluster-admin` for this first step.

```bash
oc extract secret/etc-pki-entitlement -n openshift-config-managed --to=entitlement --confirm
```

```bash
podman build -t test:test -f Containerfile -v ${PWD}/entitlement:/etc/pki/entitlement:Z .
podman run --rm -d -p 3000:3000 --name testserver test:test 

VNC_HOST=$(oc get route ${DEVWORKSPACE_ID}-${DEVWORKSPACE_COMPONENT_NAME}-3000-tiger-vnc -o jsonpath={.spec.host})
VNC_URL="https://${VNC_HOST}/vnc.html?host=${VNC_HOST}&port=443"
```

Point your Browser at ${VNC_URL}
