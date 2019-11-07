---
date: 2017-01-16
title: Como atualizar o Java em produção
categories:
  - Suporte
description: "Como atualizar o Java em produção"
type: Document
---

Seguem os passos que a gente fez na atualização do java:

## Download da última versão do Oracle Java 8 JDK em .tar.gz

Link download: https://www.oracle.com/technetwork/pt/java/javase/downloads

## Descompactar o arquivo em /opt

~~~ bash
cd /opt
  tar xzvf /tmp/jdk-8u231-linux-x64.tar.gz
  chown -R root:root jdk1.8.0_231/
~~~


##  Criar link simbólico

Criar um link apontando para o diretório do Java JDK (verificar no arquivo /opt/gf4/glassfish/config/asenv.conf em AS_JAVA="/opt/java" em 
qual path o glassfish está buscando a instalação do Java JDK, nesse caso, /opt/java)

~~~ bash
ln -sfn /opt/jdk1.8.0_231/ /opt/java
~~~

## Reiniciar o glassfish

~~~ bash
fish stop
fish start
~~~
