# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportRequests::RespostaPostbackGenerator do
  describe '#generate' do
    it 'updates report reuest status to completed' do
      report_request = ReportRequest.create!(status: :pending)

      described_class.new(report_request).generate

      expect(report_request.reload).to be_completed

    end

  end

end

