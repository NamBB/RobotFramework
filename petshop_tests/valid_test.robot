*** Settings ***
Documentation     Test Cases to check User Story
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Library           Selenium2Library


*** Variables ***
${SERVER}		localhost:3000
${HOME_URL}	http://${SERVER}/
${BROWSER}		chrome
${HOME_TITLE}	Petstore webapp

*** Keywords ***
User Has Access To WebApp
	Open Browser	${HOME_URL}	${BROWSER}

Home Page Is Rendered
	Location Should Be	${HOME_URL}
 	Page Should Contain	${HOME_TITLE}
	Wait Until Element Is Visible    css=div.pet-list

Pet Lists Displayed In Table
 	Element Should Be Visible    css=tbody.pet-list
	${count_pet_items}	Get Matching XPath Count	//tr[@class='pet-item']
	Should Be True    ${count_pet_items} > 0

User Can View Pets Name and Status
	Element Should Be Visible    css=tbody.pet-list

User Fill In A New Pet
	[Arguments]    ${name}	${status}
	Input Text    css=input.form-control.pet-name	${name}
	Input Text    css=input.form-control.pet-status	${status}

Create By Click
	Click Element    css=button#btn-create

Create By Enter
	Press Key    css=input.form-control.pet-status    \\13

User Add A New Pet
	[Arguments]    ${name}	${status}
	User Fill In A New Pet	${name}	${status}
	Create By Enter

Pet Name And Status Are Mandatory


*** Test Cases ***
US02 View The List of Pets
    Given User Has Access To WebApp
		When Home Page Is Rendered
		Then Pet Lists Displayed In Table
		And User Can View Pets Name and Status
		[Teardown]    Close Browser

US03 Add A New Pet And Click Create
    Given User Has Access To WebApp
		When Home Page Is Rendered
		And User Fill In A New Pet	Takana	stand
		Then Create By Click
		[Teardown]    Close Browser

US03 Add A New Pet And Enter
    Given User Has Access To WebApp
		When Home Page Is Rendered
		And User Fill In A New Pet	Merguez	sit
		Then Create By Enter
		[Teardown]    Close Browser
