# Virtual Display in Docker

Many applications and automated tests, such as those using Selenium for browser automation, must be run in a **graphical environment** to function properly. It would be nice to also be able to run such applications (or automated tests theron) in **headless** environments like CI/CD pipelines or cloud-based servers. Its possible, but doing so can be challenging. 

This repository helps you setup a Docker container with a virtual display suitable for running applications that normally require a graphical environment. 






## Preqequisites:
Docker installed. 
see also [here](https://github.com/dec1/practical_devops/tree/main/devops/docker/main)


## Setup:
* Run docker container based on ubuntu 20

`> docker run -it ubuntu:20.04`

Note: You may need to prefix with "sudo" depending on your setup

* Stop tzdata asking questions:

`> export DEBIAN_FRONTEND=noninteractive`


```
> apt-get update && apt-get install -y --no-install-recommends git ca-certificates xvfb xfwm4 psmisc
```
* configure git's proxy (optional)

`> git config --global http.proxy http://<proxy_ip>:<proxy-port>`

* clone this repo with the scripts

```
> cd /home
> git clone https://github.com/dec1/ci_vd
> cd ci_vd
```

* start the virtual display

```
> ./start_vd.sh 8
(xfwm4:4950): dbind-WARNING **: 15:37:13.875: AT-SPI: Error retrieving accessibility bus address: org.freedesktop.DBus.Error.ServiceUnknown: The name org.a11y.Bus was not provided by any .service files
dbus-daemon[4949]: [session uid=0 pid=4949] Activating service name='org.xfce.Xfconf' requested by ':1.1' (uid=0 pid=4950 comm="xfwm4 " label="docker-default (enforce)")
dbus-daemon[4949]: [session uid=0 pid=4949] Successfully activated service 'org.xfce.Xfconf'

(xfwm4:4950): GLib-CRITICAL **: 15:37:13.910: g_str_has_prefix: assertion 'prefix != NULL' failed

(xfwm4:4950): xfwm4-WARNING **: 15:37:14.727: Another compositing manager is running on screen 0

(xfwm4:4950): xfwm4-WARNING **: 15:37:14.732: Failed to connect to session manager: Failed to connect to the session manager: SESSION_MANAGER environment variable not defined
```
* stop the virtual display

```
root@6d940a9a4013:/home/ci_vd# ./stop_vd.sh 8
root@6d940a9a4013:/home/ci_vd# 
(xfconfd:4958): xfconfd-CRITICAL **: 15:37:27.061: Name org.xfce.Xfconf lost on the message dbus, exiting.
```





Thanks to [Clemens Anhuth ](https://kb.froglogic.com/squish/howto/using-squish-headless-systems/) 