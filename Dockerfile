# This Dockerfile sets up an environment for running Selenium tests with Chrome in a headless mode
# using a virtual display (Xvfb). It includes all necessary dependencies for Selenium and Chrome automation,
# and it sets up a Python virtual environment with Robot Framework and SeleniumLibrary for test automation.
# key to enabling this are scripts copied into the image:
# - start_vd.sh
# - stop_vd.sh  

# Use the official Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variable to stop tzdata asking questions
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites and Chrome dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    xvfb \
    xfwm4 \
    psmisc \
    procps \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    unzip \
    fonts-liberation \
    libasound2 \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libu2f-udev \
    xdg-utils \
    libvulkan1 && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install Robot Framework and SeleniumLibrary
RUN python3 -m venv /opt/robotframework && \
    /opt/robotframework/bin/pip install --upgrade pip setuptools wheel && \
    /opt/robotframework/bin/pip install robotframework robotframework-seleniumlibrary selenium

# Download and install Google Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb || true && \
    apt-get install -f -y && \
    rm google-chrome-stable_current_amd64.deb

# Download and install ChromeDriver
RUN wget -q https://chromedriver.storage.googleapis.com/126.0.6478.126/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip || true

# Set the working directory
WORKDIR /home

# Copy the scripts and test files into the container
COPY script/start_vd.sh /usr/local/bin/start_vd.sh
COPY script/stop_vd.sh /usr/local/bin/stop_vd.sh
COPY test/simple_test.robot /home/simple_test.robot
COPY test/test_chrome.py /home/test_chrome.py

# Ensure the scripts are executable
RUN chmod +x /usr/local/bin/start_vd.sh && \
    chmod +x /usr/local/bin/stop_vd.sh

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
