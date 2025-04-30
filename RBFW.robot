*** Settings ***
Documentation     Kiểm tra chức năng đăng nhập của trang web
Library           SeleniumLibrary

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}        chrome
${USERNAME}       Admin
${PASSWORD}       admin123

*** Test Cases ***
Valid Login
    Mở trình duyệt
    Đăng nhập    ${USERNAME}    ${PASSWORD}
    Kiểm tra đăng nhập thành công
    Close Browser

Invalid Login
    Mở trình duyệt
    Đăng nhập    saiuser    saipass
    Kiểm tra đăng nhập thất bại
    Close Browser

*** Keywords ***
Mở trình duyệt
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=10s

Đăng nhập
    [Arguments]    ${username}    ${password}
    Input Text    xpath=//input[@name='username']    ${username}
    Input Text    xpath=//input[@name='password']    ${password}
    Click Button    xpath=//button[@type='submit']

Kiểm tra đăng nhập thành công
    Wait Until Element Is Visible    xpath=//h6[text()='Dashboard']    timeout=10s
    Log To Console     Đăng nhập thành công

Kiểm tra đăng nhập thất bại
    Wait Until Page Contains Element    xpath=//p[contains(text(), 'Invalid credentials')]    timeout=10s
    Log To Console     Đăng nhập thất bại
