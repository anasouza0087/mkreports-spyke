# MKReports Spyke

API responsável pelo gerenciamento e processamento assíncrono de geração de relatórios.

O objetivo do projeto é centralizar a geração de relatórios da plataforma, permitindo adicionar novos tipos de relatórios e formatos de exportação de forma escalável e organizada.

---

## Objetivos

* Centralizar o processo de geração de relatórios;
* Processar relatórios de forma assíncrona;
* Controlar o ciclo de vida da geração através de status;
* Suportar diferentes formatos de exportação;
* Facilitar a inclusão de novos tipos de relatórios.

---

## Tecnologias utilizadas

* Ruby 3.3.4
* Ruby on Rails 8.0.5
* Sidekiq
* Redis
* RSpec
* SimpleCov
* RuboCop
* Rswag (Swagger / OpenAPI)

---

# Arquitetura

O fluxo de geração de relatórios segue o seguinte processo:

```
Cliente
  |
  | POST /report_requests
  |
  v
ReportRequestsController
  |
  | Criação da solicitação
  |
  v
ReportRequest
  |
  | Disparo do processamento assíncrono
  |
  v
GenerateReportJob
  |
  v
GeneratorFactory
  |
  +-------------------------+
  |                         |
  v                         v
RespostaPostbackGenerator   ClickGenerator
  |
  v
ExporterFactory
  |
  +----------------+
  |                |
  v                v
CSVExporter     XLSXExporter
  |
  v
Arquivo gerado
  |
  v
Atualização do status
```

---

# Fluxo de status

Cada solicitação de relatório possui um ciclo de processamento:

```
pending
   |
   v
processing
   |
   +------------+
   |            |
   v            v
completed      error
```

---

# API

## Criar solicitação de relatório

### POST `/report_requests`

Exemplo:

```json
{
  "report_type": "postback_response",
  "file_format": "csv"
}
```

Resposta:

```json
{
  "id": 1,
  "status": "pending",
  "report_type": "postback_response",
  "file_format": "csv",
  "file_path": null
}
```

---

## Listar relatórios

### GET `/report_requests`

Retorna todas as solicitações de relatórios criadas.

Exemplo:

```json
[
  {
    "id": 1,
    "status": "completed",
    "report_type": "postback_response",
    "file_format": "csv",
    "file_path": "/storage/reports/report_1.csv"
  }
]
```

---

# Processamento assíncrono

A geração dos relatórios é executada através do Sidekiq.

Fluxo:

1. A API recebe a solicitação;
2. Um `ReportRequest` é criado com status `pending`;
3. O `GenerateReportJob` é enviado para a fila;
4. O Sidekiq executa o processamento;
5. O Generator responsável é selecionado;
6. O arquivo é exportado;
7. O status é atualizado para `completed` ou `error`.

---

# Generators

Cada tipo de relatório possui uma classe responsável pela sua regra de geração.

Estrutura:

```
ReportRequests
├── BaseGenerator
├── RespostaPostbackGenerator
└── ClickGenerator
```

Para adicionar um novo relatório:

1. Criar um novo Generator;
2. Registrar na `GeneratorFactory`;
3. Criar os testes correspondentes.

---

# Exporters

A exportação dos arquivos é separada da geração do relatório.

Estrutura:

```
Exporters
├── CSVExporter
└── XLSXExporter
```

Novos formatos podem ser adicionados sem alterar o fluxo principal.

Exemplo:

```
PDFExporter
JSONExporter
```

---

# Instalação

Instalar dependências:

```bash
bundle install
```

Criar banco:

```bash
bin/rails db:create db:migrate
```

---

# Executando a aplicação

Subir o Rails:

```bash
bin/rails server
```

Subir Redis:

```bash
redis-server
```

Subir Sidekiq:

```bash
bundle exec sidekiq
```

---

# Testes

Executar todos os testes:

```bash
bundle exec rspec
```

Relatório de cobertura:

```
coverage/index.html
```

---

# Qualidade de código

Executar RuboCop:

```bash
bundle exec rubocop
```

Correção automática:

```bash
bundle exec rubocop -A
```

---

# Swagger

A documentação da API está disponível através do Swagger:

```
http://localhost:3000/api-docs
```

Para gerar novamente a documentação:

```bash
RAILS_ENV=test bundle exec rake rswag:specs:swaggerize
```

---

# Estrutura principal do projeto

```
app
├── controllers
│   └── report_requests_controller.rb
│
├── jobs
│   └── generate_report_job.rb
│
├── models
│   └── report_request.rb
│
└── services
    └── report_requests
        ├── generators
        ├── exporters
        └── generator_factory.rb

spec
├── jobs
├── services
└── requests
```

