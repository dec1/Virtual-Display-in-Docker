# Virtual Display in Docker

Many applications and automated tests, such as those using Selenium for browser automation, must be run in a **graphical environment** to function properly. It would be nice to also be able to run such applications (or automated tests theron) in **headless** environments like CI/CD pipelines or cloud-based servers. Its possible, but doing so can be challenging. 

This repository, and the included [scripts](script/) helps you setup a Docker container with a virtual display suitable for running applications that normally require a graphical environment. 




#### Preqequisites:
- Docker (or podman) installed. 
- clone (or download) this repo locally
    -  `git clone https://github.com/dec1/Virtual-Display-in-Docker.git`
    - `cd Virtual-Display-in-Docker`

#### Usage:
- Build an image from the included [Dockerfile](./Dockerfile) (which includes the virtual display scripts, as well as dependencies for selenium testing and chrome automation)
    - `docker build -t my_image .`

- Run a container from this image
    - `docker run -it --name my_container my_image`


###
- **Start a virtual display** (with given arbitrary number)
    - `my_display=8` 
    - `source start_vd.sh $my_display`
    
- ### Run your gui application and/or tests
    - Example:
        - use the python virtual env we set up in the container
            - `source /opt/robotframework/bin/activate`

        - simple test with selenium if we can start browser an point it to remote url        
            - `python3 /home/test_navigate.py`
                
                ```
                Example Domain
                This domain is for use in illustrative examples in documents. You may use this domain in literature without prior coordination or asking for permission.
                More information...
                ```

        ### 
        - ui test that wont work in headless mode        
            - `python3 /home/test_canvas.py`

                ```
                Test passed: ??
                ```

                ### 

        ###
        - run automated test with the [robot framework ](https://robotframework.org/)  

            - `/opt/robotframework/bin/robot /home/test.robot`
                ```==============================================================================
                Simple Test                                                                   
                ==============================================================================
                Open Browser and Check Title                                          | PASS |
                ------------------------------------------------------------------------------
                Simple Test                                                           | PASS |
                1 test, 1 passed, 0 failed
                ==============================================================================
                Output:  /home/output.xml
                Log:     /home/log.html
                Report:  /home/report.html
                ```





###
- **Stop the virtual display**
    - `stop_vd.sh $DISPLAY`




---
Thanks also to [Clemens Anhuth ](https://kb.froglogic.com/squish/howto/using-squish-headless-systems/) 