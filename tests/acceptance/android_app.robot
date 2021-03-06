*** Settings ***
Library                AppiumLibrary
Library                EyesLibrary
Resource               resources/common.robot
Resource               resources/mobile.robot
Resource               resources/android.robot

*** Variables ***
&{NEXT PAGE BUTTON}    xpath=//android.widget.ImageView[@content-desc="next page"]

*** Test Cases ***
Check Window
    [Setup]               Setup                            Android App - Check Window
    Check Eyes Window     Google Calendar    enable_eyes_log=${false}
    [Teardown]            Teardown

Check Region
    [Setup]               Setup                            Android App - Check Region
    ${location}=          Get Element Location             xpath=${NEXT PAGE BUTTON.xpath}
    Check Eyes Region     ${location['x']}                 ${location['y']}                              150             150              Next Page Button
    [Teardown]            Teardown

Is Session Open
    [Setup]               Setup                            Android App - Opened Session
    ${is open}=           Eyes Session Is Open
    Should Be True        ${is open}
    [Teardown]            Teardown

Ignore Region By Coordinates
    [Setup]               Setup                            Android App - Ignore Region By Coordinates
    ${width}=             Get Window Width
    ${target}=            Ignore Region By Coordinates     0                                             0               ${width}         70
    Check Eyes Window     Google Calendar                  target=${target}
    [Teardown]            Teardown

Ignore Region By Element
    [Setup]               Setup                            Android App - Ignore Region By Element
    ${element}=           Get Webelement                   xpath=${NEXT PAGE BUTTON.xpath}
    ${target}=            Ignore Region By Element         ${element}
    Check Eyes Window     Google Calendar                  target=${target}
    [Teardown]            Teardown

Ignore Region By Selector
    [Setup]               Setup                            Android App - Ignore Region By Selector
    ${target}=            Ignore Region By Selector        ${NEXT PAGE BUTTON.xpath}                     xpath
    Check Eyes Window     Google Calendar                  target=${target}
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Set Test Variable     ${APP PACKAGE}                   com.google.android.calendar
    Set Test Variable     ${APP ACTIVITY}                  com.android.calendar.AllInOneActivity
    Open Application      remote_url=${REMOTE URL}
    ...                   appPackage=${APP PACKAGE}
    ...                   appActivity=${APP ACTIVITY}
    ...                   nativeWebScreenshot=true
    ...                   deviceName=${DEVICE NAME}
    ...                   platformName=${PLATFORM NAME}
    ...                   automationName=UiAutomator2
    Open Eyes Session     ${API KEY}                       EyesLibrary                                   ${test name}    AppiumLibrary    enable_eyes_log=${true}

Teardown
    Close Application
    Close Eyes Session
