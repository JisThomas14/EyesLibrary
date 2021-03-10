*** Settings ***
Library      AppiumLibrary
Library      EyesLibraryExtended
Resource     resources/common.robot
Resource     resources/ios.robot
Resource     resources/mobile.robot

*** Variables ***
&{BUTTON}    xpath=//XCUIElementTypeButton[@name="ComputeSumButton"]

*** Test Cases ***
Check Window
    [Tags]                test
    [Setup]               Setup                                                                                          iOS App - Check Window
    Check Eyes Window     Google Calendar
    [Teardown]            Teardown

Check Region
    [Setup]               Setup                                                                                          iOS App - Check Region
    ${location}=          Get Element Location                                                                           xpath=${BUTTON.xpath}
    Check Eyes Region     ${location['x']}                                                                               ${location['y']}            200             200              Next Page Button
    [Teardown]            Teardown

Is Session Open
    [Setup]               Setup                                                                                          iOS App - Opened Session
    ${is open}=           Eyes Session Is Open
    Should Be True        ${is open}
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Open Application      remote_url=${REMOTE URL}
    ...                   platformName=${PLATFORM NAME}
    ...                   platformVersion=${PLATFORM VERSION}
    ...                   deviceName=${DEVICE NAME}
    ...                   app=https://github.com/joel-oliveira/EyesLibrary/raw/master/tests/resources/TestApp-iphonesimulator.zip
    ...                   automationName=XCUITest
    ...                   osname=iOS    
    ...                   browsername=Safari
    Open Eyes Session     ${API KEY}                                                                                                EyesLibrary                 ${test name}    AppiumLibrary    enable_eyes_log=${true}

Teardown
    Close Application
    Close Eyes Session
