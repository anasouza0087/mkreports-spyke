# Fluxo de geração de relatórios

```mermaid
flowchart TD
    A[Cliente / Swagger] --> B[ReportRequestsController]

    B --> C[Cria ReportRequest]
    C --> D[GenerateReportJob]

    D --> E[GeneratorFactory]

    E --> F[Report Generator]

    F --> G[ExporterFactory]

    G --> H[CSVExporter]
    G --> I[XLSXExporter]

    H --> J[Arquivo gerado]
    I --> J

    J --> K[Atualiza ReportRequest]
    K --> L[Status completed]