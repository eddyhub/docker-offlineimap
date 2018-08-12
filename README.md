# Offlineimap in a docker container
This is just a container running [offlineimap](http://www.offlineimap.org/) which I build to backup multiple accounts. Offlineimap will look for a config file in the directory /home/offlineimap/.offlineimaprc, so don't forget to map your config file to this path. The folder to sync to, which is in the offlinemap config specified, should also be mapped via a volume.

## Build
```
docker build . -t offlineimap
```

## Run

```
docker run --rm --name offlineimap \
# use the ids of the current user so
-e "USER_UID=$(id -u)" \
-e "USER_GID=$(id -g)" \
# map /etc/ssl/certs/ca-certificates.crt so the container has access to the local ca certificates
-v "/etc/ssl/certs:/etc/ssl/certs:ro" \
# map .offlinemap for cache etc
-v "${HOME}/.offlineimap:/home/offlineimap/.offlineimap" \
# the config which should be used by offlineimap
-v "${HOME}/tmp/offlineimap.conf:/home/offlineimap/.offlineimaprc" \
# folder to sync to (this path depends on the offlineimap config file)
-v "${HOME}/sync_folder:/home/offlineimap/sync_folder" \
offlineimap
```

it is also possible to pass params to offlineimap:
```
docker run --rm --name offlineimap \
-e "USER_UID=$(id -u)" \
-e "USER_GID=$(id -g)" \
-v "/etc/ssl/certs:/etc/ssl/certs:ro" \
-v "${HOME}/.offlineimap:/home/offlineimap/.offlineimap" \
-v "${HOME}/tmp/offlineimap.conf:/home/offlineimap/.offlineimaprc" \
-v "${HOME}/sync_folder:/home/offlineimap/sync_folder" \
offlineimap --dry-run -a main-acc
```

to list all possible parameters run: 
```
docker run --rm --name offlineimap \
-e "USER_UID=$(id -u)" \
-e "USER_GID=$(id -g)" \
offlineimap -h
```

## Example: offlineimap.conf
```
[general]
accounts = main-acc
maxsyncaccounts = 1

[Account main-acc]
localrepository = main-acc-local
remoterepository = main-acc-remote

[Repository main-acc-local]
type = Maildir
localfolders = ~/sync_folder/main-acc

[Repository main-acc-remote]
type = IMAP
remotehost = imap.example.com
remoteuser = user@example.com
remotepass = example-password
sslcacertfile = /etc/ssl/certs/ca-certificates.crt

```
[offlineimap.conf example](https://github.com/OfflineIMAP/offlineimap/blob/master/offlineimap.conf)


