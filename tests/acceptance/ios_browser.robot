*** Settings ***
Library     AppiumLibrary
Library     EyesLibrary
Resource    resources/common.robot
Resource    resources/mobile.robot
Resource    resources/ios.robot

*** Variable ***
&{LOGO}     id=hplogo                 xpath=//*[@id="hplogo"]

*** Test Cases ***
Check Window
    [Setup]                          Setup                                  iOS Browser - Check Window
    Check Eyes Window                Window
    [Teardown]                       Teardown

Check Region
    [Setup]                          Setup                                  iOS Browser - Check Region
    ${location}=                     Get Element Location                   ${LOGO.id}
    Check Eyes Region                ${location['x']}                       ${location['y']}                          300           300              Google Logo
    [Teardown]                       Teardown

Check Region Test
    [Setup]                          Setup                                  iOS Browser Test - Check Region
    Check Eyes Region                0                                      0                                         300           300              Google Logo
    [Teardown]                       Teardown

Check Region By Element
    [Setup]                          Setup                                  iOS Browser - Check Region By Element
    ${location}=                     Get Element Location                   ${LOGO.id}
    ${logo}=                         Get Webelement                         ${LOGO.id}
    Check Eyes Region By Element     ${logo}                                Google Logo
    [Teardown]                       Teardown

Check Region By Selector
    [Setup]                          Setup                                  iOS Browser - Check Region By Selector
    Check Eyes Region By Selector    ${LOGO.id}                             Google Logo
    [Teardown]                       Teardown

Is Session Open
    [Setup]                          Setup                                  iOS Browser - Opened Session
    ${is open}=                      Eyes Session Is Open
    Should Be True                   ${is open}
    [Teardown]                       Teardown

*** Keywords ***
Setup
    [Arguments]                      ${test name}
    Open Application                 remote_url=${REMOTE URL}
    ...                              platformName=${PLATFORM NAME}
    ...                              platformVersion=${PLATFORM VERSION}
    ...                              deviceName=${DEVICE NAME}
    ...                              browserName=Safari
    ...                              automationName=XCUITest
    Go To Url                        http://www.google.pt
    Open Eyes Session                EyesLibrary                            ${test name}                              ${API KEY}    AppiumLibrary    enable_eyes_log=true

Teardown
    Close Application
    Close Eyes Session
