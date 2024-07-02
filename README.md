docker build -t virtual-display-app .
docker run -it --name my_container virtual-display-app

start_vd.sh 8
source /opt/robotframework/bin/activate
python3 /home/test_chrome.py

/opt/robotframework/bin/robot /home/simple_test.robot

docker stop $(docker ps -a -q)
docker rm -vf $(docker ps -a -q)


# Virtual Display in Docker

Many applications and automated tests, such as those using Selenium for browser automation, must be run in a **graphical environment** to function properly. It would be nice to also be able to run such applications (or automated tests theron) in **headless** environments like CI/CD pipelines or cloud-based servers. Its possible, but doing so can be challenging. 

This repository helps you setup a Docker container with a virtual display suitable for running applications that normally require a graphical environment. 






## Preqequisites:
Docker (or podman) installed. 



## Setup:
- Run docker container based on ubuntu 20 (giving it some name eg _my_container_)

    -  `docker run -it --name my_container ubuntu:20.04`

    - _Note_: You may need to prefix with "sudo" depending on your setup. See also [here](https://github.com/dec1/practical_devops/blob/main/devops/docker/main/host.md)

- Stop tzdata asking questions:
    - `export DEBIAN_FRONTEND=noninteractive`


####
- Install prerequisites
    - `apt-get update && apt-get install -y --no-install-recommends git ca-certificates xvfb xfwm4 psmisc pstree`

####
- Clone this repo with the (`start_vd.sh`, `stop_vd.sh`) scripts
    ```shell
    cd /home
    git clone https://github.com/dec1/ci_vd
    cd ci_vd
    ```
####
- Alternatively, open a new terminal on your host machine, and
    copy the scripts into the running container:

    ```sh
    docker cp /path/to/local/start_vd.sh my_container:/usr/local/bin/start_vd.sh
    docker cp /path/to/local/stop_vd.sh my_container:/usr/local/bin/stop_vd.sh
    ```
####
- Ensure the scripts are executable within the container:

    ```sh
    docker exec -it virtual_display_container chmod +x /usr/local/bin/start_vd.sh
    docker exec -it virtual_display_container chmod +x /usr/local/bin/stop_vd.sh
    ```
####
- Start the virtual display
    `./start_vd.sh 8`


- ##### Run/Test your gui based application in the container here

####
- stop the virtual display
    - `./stop_vd.sh 8`





---
Thanks to [Clemens Anhuth ](https://kb.froglogic.com/squish/howto/using-squish-headless-systems/) 