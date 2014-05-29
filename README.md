Quickstart
==========

Build and run a non-persistent container

```shell
db && docker run --rm -it -P cjlyth/express-info
```


Launch the app in your browser (installed on the docker host)

```shell
docker ps -lq | xargs --no-run-if-empty -I{} docker port {} 3000 | xargs -I{} xdg-open http://{}
```

If you want to get at the generated code, run a command like this:

```shell
# note the cp must be run as sudo due to bugs in docker
docker ps -lq | xargs --no-run-if-empty -I{} sudo docker cp \
 {}:$(docker inspect --format='{{.Config.WorkingDir}}' $(docker ps -lq)) $(pwd)/generated
# or

docker ps -lq | xargs --no-run-if-empty -I{} sudo docker cp {}:/var/lib/angular $(mktemp -u -d -t angular-app.XXXXXXXXXXXX )
docker ps -lq | xargs --no-run-if-empty -I{} sudo docker cp {}:/var/log/angular $(mktemp -u -d -t angular-log.XXXXXXXXXXXX )
```
check it out!

```shell
find ./generated/ -type d \
     -exec test -f {}/package.json \; -printf '\nApp copied to directory %p\n\n' -prune \
     -exec ls -lsa --group-directories-first --color {} \;
```
#--force
---

NOTES
=====

For the db script, see this Gist https://gist.github.com/cjlyth/57a3457b010fafacb03c
That script requires this project folder to be in a directory named for your local repository.
For example in my dev environment this project is at the following path:

```shell
/opt/src/cjlyth/express-info
```

So, running the db script in the gist above will build an image from this project that will be tagged `cjlyth/express-info`.


echo "unsafe-perm = true" >> ~/.npmrc

NPM_CONFIG_UNSAFE_PERM=true
NPM_CONFIG_YES=true
NPM_CONFIG_NPAT=false
NPM_CONFIG_LOGLEVEL=verbose

bower_endpoint_parser

s/\(bower \)\([^"']*\)/\1\2 --config.interactive=false --allow-root --verbose --log-level debug /g
