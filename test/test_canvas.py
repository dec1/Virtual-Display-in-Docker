from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os

# Set up Chrome options
options = Options()

# Getting screenshot won't work even in headless mode (needs UI). So this is a real test of the virtual display
options.add_argument("--headless")

options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")
options.add_argument("--disable-software-rasterizer")
options.add_argument("--remote-debugging-port=9222")
options.add_argument("--verbose")

# Initialize the Chrome WebDriver
driver = webdriver.Chrome(options=options)

try:
    # Open a test page with an animated canvas element
    driver.get("https://www.rgraph.net/demos/bar-animated.html")

    # Wait for the canvas element to be present
    canvas = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.TAG_NAME, "canvas"))
    )

    # Wait for the animation to complete
    time.sleep(5)

    # Attempt to take a screenshot of the canvas element
    screenshot_path = "/home/canvas_screenshot.png"
    canvas.screenshot(screenshot_path)

    # Verify that the screenshot file is created
    assert os.path.exists(screenshot_path), f"Expected screenshot at {screenshot_path} but it was not found."

    print("Test passed: Screenshot of animated canvas taken successfully")

except Exception as e:
    print(f"Test failed: {e}")
    # Capture the page source and a screenshot for debugging
    driver.save_screenshot('/home/test_failure_screenshot.png')
    with open("/home/selenium_log.txt", "w") as log_file:
        log_file.write(driver.page_source)

finally:
    # Close the browser
    driver.quit()
