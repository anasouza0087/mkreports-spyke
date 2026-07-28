# frozen_string_literal: true
module Exporters
  class ExporterFactory
    def self.call(report_request)
      case report_request.file_format
      when "csv"
        CsvExporter.new
      when "xlsx"
        XlsxExporter.new
      else
        raise "Exporter not found"
      end
    end
  end
end
