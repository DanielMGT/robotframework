*** Settings ***

Library             SeleniumLibrary    timeout=2000
Resource            amazontests_resources.robot
Documentation       Testar funções básicas no site da Amazon com robot utilizando o método Gherkin.
Suite Setup         Abrir Navegador
Suite Teardown      Fechar Navegador

*** Variables ***

${LOGO_AMAZON}                  id=nav-logo-sprites
${MENU_HAMBURGUER}              //i[contains(@class,'hm-icon nav-sprite')]
${DESTAQUES}                    //div[@class='hmenu-item hmenu-title '][contains(.,'destaques')]
${ALIMENTOS_BEBIDAS}            //a[@data-ref-tag='nav_em_1_1_1_13']
${OFERTAS}                      //span[@class='a-size-large a-text-bold a-nowrap'][contains(.,'Ofertas em destaque')]
${ADD_CARRINHO}                 //input[contains(@name,'submit.add-to-cart')]
${QTD_ITENS}                    //span[@class='a-button-text a-declarative'][contains(.,'Qtd:1')]
${LABEL_QTD_ITENS}              //span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]
${ADD_VINHO}                    id=quantity_2
${IR_PARA_CARRINHO}             //a[contains(@data-csa-c-type,'button')]
${LABEL_CARRINHO}               //h1[contains(.,'Carrinho de compras')]
${BEBIDAS_ALCOOLICAS}           //a[contains(.,'Tudo em Bebidas Alcoólicas')]
${2_VINHOS}                     //span[@class='a-button-text a-declarative'][contains(.,'Qtd:2')]
${RESULTADO_PESQUISA}           //span[@class='a-size-medium-plus a-color-base a-text-normal'][contains(.,'RESULTADOS')]

*** Test Cases ***

Cenário 01 - Ir para aba de Alimentos e Bebidas na AMAZON e colocar um vinho no carrinho
    Dado que o usuário já tenha acessado o site
    E ido na aba "Alimentos e Bebidas"
    Quando for em outra aba "Tudo em Bebidas Alcoólicas" com o título "Bebidas Alcoólicas | Amazon.com.br"
    Então o usuário deverá selecionar "Ofertas em Vinho Branco e Rose"
    E selecionar o vinho "Woodbridge White Zinfandel Constellation"
    E colocá-lo no carrinho

Cenário 02 - Adicionar outro vinho ao carrinho
    Então iremos novamente ao carrinho
    Dado que estamos no carrinho
    Então iremos adicionar mais um vinho
    

Cenário 03 - Adicionar um Whisky no carrinho
    Dado que o usuário já tenha acessado o site
    E ido na aba "Alimentos e Bebidas"
    Quando for em outra aba "Whisky" com o título "Whisky | Amazon.com.br"
    Então o usuário deverá selecionar "Whisky Chivas Regal 12 anos, 750 ml, Dourado"
    E colocá-lo no carrinho

*** Keywords ***

Dado que o usuário já tenha acessado o site
    Wait Until Page Contains Element     ${LOGO_AMAZON}    

E ido na aba "${ABA}"
    Click Element                        ${MENU_HAMBURGUER}
    Wait Until Page Contains Element     ${DESTAQUES}
    Sleep                                1s
    Click Link                           ${ALIMENTOS_BEBIDAS}
    
Quando for em outra aba "${BEBIDAS_ALCOOLICAS}" com o título "${TITULO}"
    Click Link                           ${BEBIDAS_ALCOOLICAS}
    Wait Until Page Contains             Departamento
    Title Should Be                      title=${TITULO}
    
Então o usuário deverá selecionar "${PRODUTO}"
    Click Link                                 ${PRODUTO}
    Wait Until Page Contains                   Alimentos e Bebidas
    
E selecionar o vinho "${VINHO}"
    Click Link                           ${VINHO}

E colocá-lo no carrinho
    Wait Until Element Is Visible        ${ADD_CARRINHO}
    Click Element                        ${ADD_CARRINHO}

Dado que já foi adicionado um vinho no carrinho
    Wait Until Page Contains             ${LABEL_QTD_ITENS}

Então iremos novamente ao carrinho
    Click Element                        ${IR_PARA_CARRINHO}

Dado que estamos no carrinho
    Wait Until Element Is Visible        ${LABEL_CARRINHO}

Então iremos adicionar mais um vinho
    Click Element                        ${QTD_ITENS}
    Click Element                        ${ADD_VINHO}
    Wait Until Element Is Visible        ${2_VINHOS}    
    