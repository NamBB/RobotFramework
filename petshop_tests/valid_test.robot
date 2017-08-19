*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Library           Selenium2Library

*** Variables ***
${SERVER}		localhost:3000
${HOME_URL}	http://${SERVER}
${BROWSER}		chrome

*** Keywords ***
User Has Access To WebApp
	Open Browser To Home Page

Open Browser To Home Page
	Open Browser	${HOME_URL}	${BROWSER}

Home Page Is Rendered
	Location Should Be	${HOME_URL}
	Title Should Be    Petstore webapp

Pet Lists Displayed In Table
	

Input Login
	[Arguments]    ${username}    ${password}
	Input Text	username_field	${username}
	Input Text	password_field	${password}

Submit Credentials
	Click Element	login_button

Welcome Page Should Be Open
	Location Should Be	${WELCOME_URL}

*** Test Cases ***
US02 View The List of Pets
    Given User Has Access To WebApp
		When Home Page Is Rendered
		Then Pet Lists Displayed In Table
		[Teardown]    Close Browser
