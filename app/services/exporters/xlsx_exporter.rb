# frozen_string_literal: true

module Exporters
  class XlsxExporter
    def generate(report_request)
      path = Rails.root.join(
        "storage",
        "reports",
        "report_#{report_request.id}.xlsx"
      )

      FileUtils.mkdir_p(path.dirname)

      package = Axlsx::Package.new
      workbook = package.workbook

      workbook.add_worksheet(name: "Relatório") do |sheet|
        sheet.add_row ["ID", "Nome", "Telefone"]
        sheet.add_row [1, "João", "11999999999"]
        sheet.add_row [2, "Maria", "11888888888"]
      end
      package.serialize(path)
      path.to_s
    end
  end
end

