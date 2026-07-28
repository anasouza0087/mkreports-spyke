require "rails_helper"

RSpec.describe Exporters::ExporterFactory do
  describe ".call" do
    it "returns csv exporter" do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :postback_response,
        file_format: :csv
      )

      exporter = described_class.call(report_request)
      expect(exporter).to be_a(Exporters::CsvExporter)
    end

    it "returns xslsx exporters" do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :postback_response,
        file_format: :xlsx
      )

      exporter = described_class.call(report_request)

      expect(exporter).to be_a(Exporters::XlsxExporter)
    end
  end
end
