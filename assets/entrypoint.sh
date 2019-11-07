#!/bin/bash
#
# Author: Everton de Vargas Agilar
# Date: 06/11/2019
#
# Objetivo: Entrypoint do servidor da base de conhecimento do CPD/UFSM
#
#
#
## Histórico
#
# Data       |  Quem           |  Mensagem  
# -----------------------------------------------------------------------------------------------------
# 06/11/2019  Everton Agilar     Versão inicial
#
#
#
########################################################################################################

# configura o arquivo de hosts
echo '200.132.39.65 alpha.cpd.ufsm.br' 		>> /etc/hosts

echo -e "\033[00;37mServidor da base de conhecimento do \033[01;34mCPD/UFSM\033[01;37m"
cd /var/opt
#git clone -q --depth 'https://evertonagilar:unb960101$$$@alpha.cpd.ufsm.br/desenvolvimento/knowledge-base'
GIT_PASSWD='unb960101$$$'
echo 'Fazendo download do projeto...'
git clone -q --depth 1 https://evertonagilar:$GIT_PASSWD@alpha.cpd.ufsm.br/desenvolvimento/knowledge-base
echo 'Entrando no projeto'
cd knowledge-base/src
jekyll serve
