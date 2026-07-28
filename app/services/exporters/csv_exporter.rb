# frozen_string_literal: true

require "csv"

module Exporters
  class CsvExporter
    def generate(report_request)
      path = Rails.root.join(
        "storage",
        "reports",
        "report_#{report_request.id}.csv"
      )

      FileUtils.mkdir_p(path.dirname)

      CSV.open(path, "w") do |csv|
        csv << %w[ID Nome Telefone]
        csv << [1, "João", "11999999999"]
        csv << [2, "Maria", "11888888888"]
      end
      path.to_s
    end
  end
end