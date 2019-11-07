---
date: 2019-11-06
title: Gerar certificado ICP-Brasil barramento PEN
video_id: 42vlM8bvrtk
categories:
  - Desenvolvimento
description: "Como gerar um certificado ICP-Brasil para o barramento PEN"
type: Video
---
O certificado do PEN deve ser criado a partir de um terminal de comando no Linux com o utilitário openssl.

## Criar a chave

~~~ bash
sudo openssl genrsa -des3 -out UFSM-PEN-PRODUCAO.key 2048
~~~


## Criar arquivo do certificado

~~~ bash
sudo openssl req -new  -key ~/desenvolvimento/chave/UFSM-PEN-PRODUCAO.key -out  UFSM-PEN-PRODUCAO.csr
~~~

## Abrir chamado no OTRS para CPD/Suporte/Identidade e anexar o arquivo CSR

Responsável no suporte: Carlos Roberto Grieco de Moraes
