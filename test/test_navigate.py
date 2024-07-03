from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

# Set up Chrome options
options = Options()

# normally most chrome chrome functionality would be fine, even without a display,
# as long as we start it with the "headless" option. But to show the  virtual display works, 
# we'll omit the headless option
#
# options.add_argument("--headless")

options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

# Initialize the Chrome WebDriver
driver = webdriver.Chrome(options=options)

# Open the URL
driver.get("https://www.example.com")

# Print the title of the page
print(driver.title)

# Print additional text from the body
body_text = driver.find_element(By.TAG_NAME, 'body').text
print(body_text)

# Close the browser
driver.quit()
