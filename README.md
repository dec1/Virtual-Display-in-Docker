# ci_vd


`> docker run -it ubuntu:20.04`

stop tzdata asking questions

`> export DEBIAN_FRONTEND=noninteractive`


```> apt-get update
> apt-get install -y --no-install-recommends git ca-certificates xvfb xfwm4 pstree
```
configure git's proxy (if necessary)

`> git config --global http.proxy http://<proxy_ip>:<proxy-port>`

```
> cd /home
> git clone https://github.com/dec1/ci_vd
> cd ci_vd
> ./start_vd.sh 8
````
