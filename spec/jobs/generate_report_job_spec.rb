require 'rails_helper'

RSpec.describe GenerateReportJob do
  describe '#perform' do
    it 'calls the report generator' do
      report_request = ReportRequest.create!(status: :pending)

      generator = instance_double(
        ReportRequests::BaseGenerator
      )

      allow(ReportRequests::GeneratorFactory)
        .to receive(:call)
              .with(report_request)
              .and_return(generator)

      expect(generator)
        .to receive(:generate)

      described_class.new.perform(report_request.id)
    end
  end
end
