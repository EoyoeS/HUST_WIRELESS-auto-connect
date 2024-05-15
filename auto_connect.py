import time
import ipaddress

from selenium.webdriver import Chrome
from selenium.webdriver.common.keys import Keys

driver = Chrome()
driver.get("http://www.baidu.com")
with open('login_info', encoding='utf-8') as f:
    username, pwd = map(lambda x: x.strip(), f.readlines()[:2])
server_ip = driver.current_url.split('/')[2].split(':')[0]
try:
    if not ipaddress.ip_address(server_ip).is_private:
        exit(-1)
except ValueError:
    exit(-1)
time.sleep(1)
input = driver.find_element(value='username')
input.send_keys(username)
driver.find_element(value='pwd_hk_posi').click()
input = driver.find_element(value='pwd')
input.send_keys(pwd)
driver.find_element(value='loginLink_div').click()
time.sleep(2)
driver.quit()

