---
date: 2019-11-06
title: Fuso horário errado
categories:
  - Java
description: "Como atualizar o banco de dados de timezone do Java Runtime para corrigir o problema de fuso horário"
type: Document
---
O java utiliza uma base de dados própria para conhecer os fusos e o início e fim do horário de verão.

Neste tópico você vai:
* saber como atualizar o banco de dados de fusos
* saber como identificar o banco de dados atual


## Como atualizar

Basta atualizar usando a ferramenta TZUpdater da própria Oracle que está disponível em https://www.oracle.com/technetwork/java/javase/downloads/tzupdater-download-513681.html.

~~~ bash
$ sudo java -jar tzupdater.jar -l
Using https://www.iana.org/time-zones/repository/tzdata-latest.tar.gz as source for tzdata bundle.
JRE has the same version as the tzupdater provided one (tzdata2019c).
~~~

## Verificando o banco de dados de fusos atual

Utilize o seguinte comando para saber a versão do banco de dados atual.

~~~ bash
$ java -jar tzupdater.jar -V
tzupdater version 2.3.0-b01
JRE tzdata version: tzdata2018g
tzupdater tool would update with tzdata version: tzdata2019c
~~~

