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
echo 'Fazendo download do projeto knowledge-base do GitLab...'
git clone --depth 1 https://$GIT_USER:$GIT_PASSWD@alpha.cpd.ufsm.br/desenvolvimento/knowledge-base
echo 'Entrando no projeto knowledge-base...'
cd knowledge-base/src
echo 'Ativando crond'
crond
echo 'Iniciando jekyll...'
jekyll serve
