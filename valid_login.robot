*** Settings ***
Documentation   Test cases to check if user using valid credentials (username, email and password) can log in to www.rossmann.pl profile site.

Library    Selenium2Library

*** Variables ***
${SERVER}    www.rossmann.pl
${BROWSER}    Firefox
${DELAY}    1
${VALID_USER}    rosstester
${VALID_EMAIL}    rosstester@wp.pl
${VALID_PASSWORD}    tester1234
${NOT_VALID_PASSWORD}    tester1234
${LOGIN_URL}    https://${SERVER}/login
${PROFILE_URL}    https://${SERVER}/profil


${LOGIN_LOGINSITE_BTN}    //div[@class="form form-horizontal hidden-md hidden-sm hidden-xs"]//button[@data-bind="click: login"]
${LOGIN_FIELD}    //div[@class="form form-horizontal hidden-md hidden-sm hidden-xs"]//input[@data-bind="textInput: Login, enterkey: login"]
${PASSWORD_FIELD}    //div[@class="form form-horizontal hidden-md hidden-sm hidden-xs"]//input[@data-bind="textInput: Password, enterkey: login"]
${TEXT_AT_LOGINSITE}    //h1[contains(.,'Mam konto w Rossmann.pl - Logowanie')]
${USERNAME_AT_PROFILE}    //h1[@data-bind="text: Nick"]
${CLOSE_POPUP_BTN}    //button[@class="close"]




*** Test Cases ***
TC_01_17052018_TM - Valid LogIn to rossmann.pl - username
    Open Maximized Browser
    Close Popup Banner If Present
    Wait For LogIn Text At Login Site
    Verify If Login Site Tite Is Correct
    Capture Page Screenshot
    Insert Valid Username In LogIn Field    ${VALID_USER}
    Insert Valid Password In Password Field    ${VALID_PASSWORD}
    Click LogIn Button
    Verify If Main Site Tite Is Correct
    Go To Profile Site
    Wait For UserName Text At Login Site
    Verify If Profile Site Tite Is Correct
    Verify If Username Object Is Present
    Capture Page Screenshot
    Close All Browsers

TC_02_17052018_TM - Valid LogIn to rossmann.pl - email
    Open Maximized Browser
    Close Popup Banner If Present
    Wait For LogIn Text At Login Site
    Verify If Login Site Tite Is Correct
    Capture Page Screenshot
    Insert Valid Username In LogIn Field    ${VALID_EMAIL}
    Insert Valid Password In Password Field    ${VALID_PASSWORD}
    Click LogIn Button
    Verify If Main Site Tite Is Correct
    Go To Profile Site
    Wait For UserName Text At Login Site
    Verify If Profile Site Tite Is Correct
    Verify If Username Object Is Present
    Capture Page Screenshot
    Close All Browsers

*** Keywords ***
Open Maximized Browser
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Verify If Popup Banner Is Present
    Element Should Be Enabled    ${CLOSE_POPUP_BTN}

Close Popup Banner If Present
    ${status} 	${value} = 	Run Keyword And Ignore Error 	Verify If Popup Banner Is Present
    Run Keyword If 	'${status}' == 'PASS' 	Click Element    ${CLOSE_POPUP_BTN}

Verify If Main Site Tite Is Correct
    Title Should Be    	Drogeria Rossmann - kosmetyki online, perfumy sklep, porady, drogeria internetowa

Verify If Login Site Tite Is Correct
    Title Should Be    Rossmann > userLogin

Verify If Profile Site Tite Is Correct
    Title Should Be    Rossmann > profil

Click LogIn Button
    Click Element    ${LOGIN_LOGINSITE_BTN}

Wait For LogIn Text At Login Site
    Wait Until Page Contains Element    ${TEXT_AT_LOGINSITE}

Wait For UserName Text At Login Site
    Wait Until Page Contains Element    ${USERNAME_AT_PROFILE}

Verify If LogIn Text Value Is Correct
    [Arguments]   ${login_text}
    Element Should Contain    ${TEXT_AT_LOGINSITE}   ${login_text}

Verify Text Present Login Site
    [Arguments]    ${text_at_login_site}
    Element Should Contain    ${TEXT_AT_LOGINSITE}    ${text_at_login_site}

Go To Profile Site
    Go To   ${PROFILE_URL}

Verify If Username Object Is Present
    Wait Until Element Is Visible    ${USERNAME_AT_PROFILE}

Verify If Username Object Is Correct
    [Arguments]   ${username_value}
    Element Should Contain    ${USERNAME_AT_PROFILE}    ${username_value}

Insert Valid Username In LogIn Field
    [Arguments]    ${username}
    Input Text    ${LOGIN_FIELD}    ${username}

Insert Valid Password In Password Field
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Wait few seconds
    Sleep    ${DELAY}
