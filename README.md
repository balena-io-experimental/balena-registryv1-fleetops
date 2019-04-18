# A v1 Docker registry and fleetops releated tools

A quick and easy way to run a v1 Docker registry on a Balena device, and have a legacy (17.03) Docker available to populate that registry with the required images.

## Usage

Add the required Docker hub credentials in `secrets.yml`:
```
'':
  username: aaaa
  password: xxxxxxxx
```

Deploy it on an x86-64 device (NUC, Virtualbox NUC, QEMU)... with
```
balena push $APPNAME -R secrets.yml
```

Add a new device environment variable called `REGISTRY_TOKEN` which will be the authentication token to push to this registry.

Enable the Public Device URL for remote access.

In the `legacy-docker` service run `populate.sh` to push the docker images required by the 1.x updater to this local Docker registry.

Use the Device Public URL `<UUID>.balena-devices.com` in the tooling that requires pulling from the v1 registry.