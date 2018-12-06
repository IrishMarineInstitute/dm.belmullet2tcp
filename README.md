# dm.belmullet2tcp

A simple bridge of the ais messages received on the Belmullet antenna, to tcp (port 2103).

The kafka consumer is launched on demand (when a tcp connection is established) using inetd.

Note the command configuration is for the old version of kafka and will need updated on kafka migration.

```
docker build -t 127.0.0.1:5000/belmullet2tcp .

docker push 127.0.0.1:5000/belmullet2tcp

docker service create \
        --name belmullet2tcp \
        --publish published=2103,target=2103,mode=host \
        --host kafka01:172.17.1.86 \
        --host kafka02:172.17.1.87 \
        --host kafka03:172.17.1.88 \
        127.0.0.1:5000/belmullet2tcp
```

