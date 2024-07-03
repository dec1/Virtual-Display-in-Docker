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
    # Open a test page with a file upload input
    driver.get("https://www.w3schools.com/howto/howto_html_file_upload_button.asp")

    # Locate the file input element
    upload_element = driver.find_element(By.ID, "myFile")

    # Specify the file path
    file_path = "/home/test_file.txt"

    # Create a test file to upload
    with open(file_path, "w") as f:
        f.write("This is a test file.")

    # Upload the file
    upload_element.send_keys(file_path)

    # Wait for a moment to see the uploaded file
    time.sleep(5)

    # Verify that the file has been uploaded by checking the value of the input element
    uploaded_file_path = upload_element.get_attribute('value')
    
    # The value attribute should end with the file name
    assert uploaded_file_path.endswith("test_file.txt"), f"Expected file path to end with 'test_file.txt' but got {uploaded_file_path}"

    print("Test passed: File uploaded successfully")

except Exception as e:
    print(f"Test failed: {e}")

finally:
    # Close the browser
    driver.quit()
