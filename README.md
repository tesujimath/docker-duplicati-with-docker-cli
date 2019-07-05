# A container for Duplicati, with Docker CLI included

This container adds the Docker CLI to [linuxserver/duplicati](https://hub.docker.com/r/linuxserver/duplicati).

This enables pre-backup scripts to run things in other containers.  For example, running `mysqldump` in your MariaDB container before Duplicati backs up the resulting dump files.  (If this is your use case, consider using `mysqldump --tab` to backup an uncompressed table per file, to mitigate de-duplication issues.)

In order to use `docker` from within the container, ensure to mount the docker socket `/var/run/docker.sock` into the container.  Note the security implications of this:  your Duplicati container is then trusted with root access to all your other containers.

## Examples

Here's an example fragment from a `docker-compose.yml` file:

```
  duplicati:
    image: tesujimath/duplicati-with-docker-cli:latest
    restart: always
    volumes:
      - backup:/backup
      - wordpress:/wordpress
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - "8200:8200"
```

And here's an example script fragment to run your backup script `backup-databases` in your `db` container from the Duplicati container:

```
cname="db"
cid=`docker ps --filter name=$cname --format '{{ .ID }}'`
test -n "$cid" || { echo >&2 "can't find $cname container - abort"; exit 1; }
exec docker exec $opts $cid backup-databases
```
