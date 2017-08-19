*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Library           Selenium2Library

*** Variables ***
${SERVER}		localhost:7272
${LOGIN_URL}	http://${SERVER}
${BROWSER}		chrome
${WELCOME_URL}	http://${SERVER}/welcome.html

*** Keywords ***
Open Browser To Login Page

	Open Browser	${LOGIN_URL}	${BROWSER}
Input Login
	[Arguments]    ${username}    ${password}
	Input Text	username_field	${username}
	Input Text	password_field	${password}

Submit Credentials
	Click Element	login_button

Welcome Page Should Be Open
	Location Should Be	${WELCOME_URL}

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Login	demo	mode
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Close Browser
