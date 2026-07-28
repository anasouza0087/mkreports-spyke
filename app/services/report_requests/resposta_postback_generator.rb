# frozen_string_literal: true

module ReportRequests
  class RespostaPostbackGenerator < BaseGenerator
    def generate
      report_request.processing!

      exporter = Exporters::ExporterFactory.call(report_request)
      file_path = exporter.generate(report_request)

      report_request.update!(file_path: file_path)
      report_request.completed!
    rescue StandardError
      report_request.error!
    end
  end
end
