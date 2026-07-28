# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportRequests::RespostaPostbackGenerator do
  describe '#generate' do
    it 'updates report request status to completed' do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :postback_response,
        file_format: :csv)

      exporter = instance_double(Exporters::CsvExporter)

      allow(Exporters::ExporterFactory)
        .to receive(:call)
              .with(report_request)
              .and_return(exporter)

      allow(exporter)
        .to receive(:generate)
              .with(report_request)
              .and_return("storage/reports/report_1.csv")

      described_class.new(report_request).generate

      report_request.reload

      expect(report_request).to be_completed
      expect(report_request.file_path)
        .to eq("storage/reports/report_1.csv")
      expect(Exporters::ExporterFactory)
        .to have_received(:call)
              .with(report_request)

      expect(exporter)
        .to have_received(:generate)
              .with(report_request)

    end

  end

end

