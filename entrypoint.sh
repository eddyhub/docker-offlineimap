#!/bin/sh
set -e
USER=offlineimap
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}
# create user with uid and gid matching that of the host user
if ! getent passwd ${USER} >/dev/null; then
	adduser -u ${USER_UID} -D -g ${USER} ${USER}
fi
chown -R ${USER}:${USER} /home/${USER}
cmd="offlineimap $@"
echo "executing ${cmd}"
su - ${USER} -c "${cmd}"
