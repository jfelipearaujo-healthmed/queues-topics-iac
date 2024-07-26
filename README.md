# Queues & Topics IaC

Repositório responsável pelo provisionamento de filas e tópicos.

# Diagrama de Componentes

O diagrama de componentes abaixo representa de forma geral o que está sendo provisionado no projeto:

![architecture](./docs/architecture.svg)

# Desenvolvimento Local

## Requisitos

- [Terraform](https://www.terraform.io/downloads.html)
- [Terraform Docs](https://github.com/terraform-docs/terraform-docs)
- [AWS CLI](https://aws.amazon.com/cli/)

## Implantação manual

### Atenção

Antes de implantar o cluster, certifique-se de definir as variáveis ​​de ambiente `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`.

Esteja ciente de que esse processo levará alguns minutos (~2 minutos) para ser concluído.

Para implantar o cluster manualmente, execute os seguintes comandos em ordem:

```bash
make init
make check # this will execute fmt, validate and plan
make apply
```

Para destruir o cluster, execute o seguinte comando:

```bash
make destroy
```

## Implantação Automatizada

A implantação automatizada é acionada por uma GitHub Action.

# Provisionamento

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version |
| ------------------------------------------------------------------------- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4   |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | 5.38.0  |
## Providers

No providers.
## Inputs

| Name                                                 | Description                               | Type          | Default                                     | Required |
| ---------------------------------------------------- | ----------------------------------------- | ------------- | ------------------------------------------- | :------: |
| <a name="input_region"></a> [region](#input\_region) | The default region to use for AWS         | `string`      | `"us-east-1"`                               |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)       | The default tags to use for AWS resources | `map(string)` | <pre>{<br>  "App": "queue_topic"<br>}</pre> |    no    |
## Modules

| Name                                                                                            | Source                | Version |
| ----------------------------------------------------------------------------------------------- | --------------------- | ------- |
| <a name="module_appointment_creator"></a> [appointment\_creator](#module\_appointment\_creator) | ./modules/queue_topic | n/a     |
| <a name="module_review_processor"></a> [review\_processor](#module\_review\_processor)          | ./modules/queue_topic | n/a     |
## Resources

No resources.
## Outputs

No outputs.
<!-- END_TF_DOCS -->

# Licença

Este projeto é licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.