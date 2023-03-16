*** Settings ***

Library            SeleniumLibrary
Documentation      Arquivo de Coniguração e Keywords dos testes

*** Variables ***

${URL}            https://www.amazon.com.br/
${BROWSER}        gc

*** Keywords ***

Abrir Navegador
    Open Browser        ${URL}    ${BROWSER}
    Maximize Browser Window

Fechar Navegador
    Close Browser