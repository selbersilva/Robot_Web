*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

Library  SeleniumLibrary
Library  OperatingSystem

*** Variables ***
# Caminho absoluto para a pasta onde as capturas serão salvas
${EVIDENCE_FOLDER}    C:/Users/user/Desktop/Selber/Robot_Web/Capture/img
${login}   Admin
${password}   admin123
@{Dias_da_semana}   Domingo    Segunda    Terca    Quarta    Quinta    Sexta    Sabado
&{Cadastro}   nome=Selber   email=sel@gmail.com   mae=Iracy

*** Keywords ***
Acessar a aplicacao
    Ensure Evidence Folder Exists
    Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login  chrome  options=add_argument("--start-maximized")  
    Wait Until Element Is Enabled  xpath://input[@name="username"]  20
    Input Text  xpath://input[@name="username"]    ${login}
    Input Password  xpath://input[@placeholder="Password"]    ${password}
    Capture Selenium Screenshot    before_click_login
    Click Button  xpath=//button[text()=' Login ']  
    Sleep    10s
    Page Should Contain Image    //img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]
    Ensure Evidence Folder Exists
    Capture Selenium Screenshot    selenium-screenshot-before-click
    Page Should Contain Image    //img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]
    Wait Until Element Is Visible    //img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]    20
    Capture Selenium Screenshot    selenium-screenshot-after-login
    
Capture Selenium Screenshot
    [Arguments]    ${screenshot_name}
    Ensure Evidence Folder Exists
    ${file_path}=    Set Variable    ${EVIDENCE_FOLDER}/${screenshot_name}.png
    Log To Console    Salvando Screenshot em: ${file_path}
    Capture Page Screenshot    ${file_path}

Ensure Evidence Folder Exists
    # Verifica se a pasta de capturas existe, caso contrário, cria a pasta
    Directory Should Exist    ${EVIDENCE_FOLDER}
    Run Keyword And Ignore Error    Create Directory    ${EVIDENCE_FOLDER}

*** Test Cases ***

Logar com User e Password correto, clicar no botão e armazenar evidências
    [Tags]   Logar
    Acessar a aplicacao 
    Click Link    //a[@href='/web/index.php/admin/viewAdminModule']  
    Sleep    3
    Element Should Be Visible    //h6[text()='User Management']
    Close Browser


Analisando Variaveis
    [Tags]   Var
    Log To Console    ${login}
    Log To Console    ${Dias_da_semana[6]}
    Log To Console    ${Cadastro.mae}


