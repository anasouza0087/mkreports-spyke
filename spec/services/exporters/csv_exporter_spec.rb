require "rails_helper"

RSpec.describe Exporters::CsvExporter do
  describe "#generate" do
    it "creates the csv file and returns its path" do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :postback_response,
        file_format: :csv
      )

      path = described_class.new.generate(report_request)

      expect(File.exist?(path)).to be true
      expect(path).to end_with(".csv")
    end
  end
end