from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

# Set up Chrome options
options = Options()

# Uploading a file wont work even in headless mode (needs a ui dialog). So this is a real test of the virtual display
options.add_argument("--headless")

options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")

# Initialize the Chrome WebDriver
driver = webdriver.Chrome(options=options)

try:
    # Open a test page with an animated canvas element
    driver.get("https://www.rgraph.net/demos/bar-animated.html")

    # Wait for the animation to complete
    time.sleep(5)

    # Take a screenshot of the canvas element
    canvas = driver.find_element(By.TAG_NAME, "canvas")
    screenshot_path = "/home/canvas_screenshot.png"
    canvas.screenshot(screenshot_path)

    # Verify that the screenshot file is created
    import os
    assert os.path.exists(screenshot_path), f"Expected screenshot at {screenshot_path} but it was not found."

    print("Test passed: Screenshot of animated canvas taken successfully")

except Exception as e:
    print(f"Test failed: {e}")

finally:
    # Close the browser
    driver.quit()
