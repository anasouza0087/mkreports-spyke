# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportRequests::GeneratorFactory do
  describe '.call' do
    it 'returns postback generator' do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :postback_response
      )

      generator = described_class.call(report_request)

      expect(generator)
        .to be_a(ReportRequests::RespostaPostbackGenerator)
    end

    it 'returns click generator' do
      report_request = ReportRequest.create!(
        status: :pending,
        report_type: :click
      )

      generator = described_class.call(report_request)

      expect(generator)
        .to be_a(ReportRequests::ClickGenerator)
    end
  end
end
