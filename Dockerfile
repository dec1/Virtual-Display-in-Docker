# Use the official Ubuntu 24.04 as the base image
FROM ubuntu:24.04

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
    liboss4-salsa-asound2 \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libu2f-udev \
    xdg-utils && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install Robot Framework and SeleniumLibrary
RUN python3 -m venv /opt/robotframework && \
    /opt/robotframework/bin/pip install --upgrade pip setuptools wheel && \
    /opt/robotframework/bin/pip install robotframework robotframework-seleniumlibrary

# Install Chrome and ChromeDriver
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install && \
    wget -q https://chromedriver.storage.googleapis.com/91.0.4472.101/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver

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
