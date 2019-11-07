---
date: 2017-01-16
title: Atualizar portais web manualmente
categories:
  - Deployment
description: "Passo a passo para atualização manual dos portais web"
type: Document
---
Embora o processo de atualização dos portais esteja caminhando para ser automático com o GitLab, este tutorial demonstra passo a passo os procedimentos que são realizados atualmente.


## 0) Criar tarefa no OTRS e associar todas as tarefas a serem implantadas

~~~ bash
Processo: CPD::NOC::Requisição de mudança
Assunto: Atualização dos portais
Texto: Atualização semanal dos portais
Associar as tarefas que serão implantadas a esta nova tarefa (Outros >> Associar)
~~~

## 1) Listar tarefas de implantação Java no OTRS

~~~ bash
1.1.    Baixar (ou atualizar) as versões TRUNK de cada projeto a ser implantado.
1.2.    Em cada projeto, ajustar o pom.xml (tirar o sufixo -SNAPSHOT e ajustar as versões das dependências para as tags mais atuais)
1.2.1.  Nos projetos EJB, não esquecer de executar o ant target "updateChildModules".
1.3.    Gerar a tag. Se usar o tortoise:
1.3.1.  Clique direito no dir >> SVN branch/tag
1.3.2.  Altere o "To path" de "projeto/trunk" para "projeto/tags/X.Y.Z"
1.3.3.  Marque o radio "Working Copy".
1.3.4.  OK.
1.3.5.  Reabra o pom, incremente a versao e recoloque o -SNAPSHOT. Reajuste as versões das dependências para as SNAPSHOT mais atuais.
1.3.5.  Faça o commit da trunk incrementada.
~~~

## 2) Abrir o Project Builder

~~~ bash
2.1.    Baixe o Project Builder do repo "svn+ssh://viper.cpd.ufsm.br/var/svn/fontes", projeto "project-builder/trunk"
2.2.    Compile-o, execute-o e configure-o.
2.2.1.  Se vc nao instalou o maven, apnas indique o caminho do maven incorporado no netbeans: "C:\Program Files\NetBeans 8.2\java\maven"
2.2.2.  Configure "Destino download" e "Destino da coleta" se desejar. Sugiro apontar para pastas em disco SSD.
~~~

## 3) Após configurado, você verá a lista de tags (por padrão). Linhas em negrito indicam tag feita nos últimos 5 dias.

~~~ bash
3.1.    Se não é a primeira atualização que vc faz, recomendo executar um "Limpar" e conferir as pastas "Destino download" e "Destino da coleta".
3.2.    Agora, apenas execute "Construir".
~~~

## 4) Se tudo ocorreu bem (Tudo verde), a pasta "Destino da coleta" conterá todos os artefatos de implantação.

## 5) Será necessário atualizar:

~~~ bash
5.1.    edge        (maq testes)
5.2.    wportal02   (maq secundária, 200.18.33.117  wportal02.si.ufsm.br)
5.3.    wportal03   (maq principal,  200.18.33.142  wportal03.si.ufsm.br)
~~~

## 6) Pula

## 7) Atualizando a edge:

~~~ bash
7.1.    conecte-se na maq. login: interno
7.2.    execute o comando "fish prepupdt domain1" e aguarde...
7.3.    faça logout
7.4.    conecte-se novamente, agora com login: producao // 
7.5.    na pasta "/opt/glassfish-4.1/glassfish/domains/domain1/autodeploy":
7.5.1.  largue o arquivo "sie-core.ear" e espere completar o deploy.
7.5.2.  largue os demais "*.ear" e espere completar os deploys.
7.5.3.  largue os "*.war" e espere completar os deploys.
~~~

## 8) Antes de atualizar as portais:

~~~ bash
8.1.    Certifique-se de que a edge está tudo OK.
8.2.    Conecte-se na maq do haproxy: host: 200.18.33.123 // login: interno
8.3.    sudo nano /etc/haproxy/haproxy.cfg
8.3.1. nas linhas 153 a 154, troque (apontar para a wportal02)
		# default_backend producao_wportal02
		default_backend producao_wportal03
		por
		default_backend producao_wportal02
		# default_backend producao_wportal03
8.4.    sudo service haproxy reload
~~~

## 9) Atualizando a wportal03 (200.18.33.142):

~~~ bash
9.1.    conecte-se na maq. login: interno
9.2.    execute o comando "fish prepupdt domain1" e aguarde...
9.2.1.  Se precisar  atualizar o domínio dos timers, também execute o comando "fish prepupdt domain2" e aguarde...
9.2.2.  Nesse domínio vc só fará deploy da "sie-core.ear" e do "cpd-aghu.ear"
9.3.    faça logout
9.4.    conecte-se novamente, agora com login: producao 
9.5.    na pasta "/opt/glassfish-4.1/glassfish/domains/domain1/autodeploy":
9.5.1.  largue o arquivo "sie-core.ear" e espere completar o deploy.
9.5.2.  largue os demais "*.ear" e espere completar os deploys.
9.5.3.  largue os "*.war" e espere completar os deploys.
9.6.    Se precisar  atualizar o domínio dos timers, na pasta "/opt/glassfish-4.1/glassfish/domains/domain2/autodeploy":
9.6.1.  largue o arquivo "sie-core.ear" e espere completar o deploy.
9.6.2.  largue o arquivo "cpd-aghu.ear" e espere completar o deploy.
~~~

## 10) Antes de atualizar a wportal02:

~~~ bash
10.1.    Conecte-se na maq do haproxy: host: 200.18.33.123 // login: interno
10.2.    sudo nano /etc/haproxy/haproxy.cfg
10.2.1. nas linhas 153 a 154, troque (reapontar para a wportal03)
		default_backend producao_wportal02
		# default_backend producao_wportal03
		por
		# default_backend producao_wportal02
		default_backend producao_wportal03
10.2.2. Nas linhas  131 a 133, troque (colocar ru em manutenção)
		use_backend domain1_wportal02 if is_mobile_ru
		# http-request set-path /manutencao/index.html  if is_mobile_ru !is_external !is_local !is_ws_json
		# use_backend local if is_mobile_ru
		por
		# use_backend domain1_wportal02 if is_mobile_ru
		http-request set-path /manutencao/index.html  if is_mobile_ru !is_external !is_local !is_ws_json
		use_backend local if is_mobile_ru
10.3.   sudo service haproxy reload
~~~

## 11) Atualizando a wportal02 (200.18.33.117):

~~~ bash
11.1.    conecte-se na maq. login: interno
11.2.    execute o comando "fish prepupdt domain1" e aguarde...
11.3.    faça logout
11.4.    conecte-se novamente, agora com login: producao 
11.5.    na pasta "/opt/glassfish-4.1/glassfish/domains/domain1/autodeploy":
11.5.1.  largue o arquivo "sie-core.ear" e espere completar o deploy.
11.5.2.  largue os demais "*.ear" e espere completar os deploys.
11.5.3.  largue os "*.war" e espere completar os deploys.
~~~

## 12) Finalizando...

~~~ bash
12.1.    Conecte-se na maq do haproxy: host: 200.18.33.123 // login: interno
12.2.    sudo nano /etc/haproxy/haproxy.cfg
12.2.1. Nas linhas 131 a 133, troque (tirar ru de manutenção)
		# use_backend domain1_wportal02 if is_mobile_ru
		http-request set-path /manutencao/index.html  if is_mobile_ru !is_external !is_local !is_ws_json
		use_backend local if is_mobile_ru
		por
		use_backend domain1_wportal02 if is_mobile_ru
		# http-request set-path /manutencao/index.html  if is_mobile_ru !is_external !is_local !is_ws_json
		# use_backend local if is_mobile_ru
12.3.   sudo service haproxy reload
~~~
