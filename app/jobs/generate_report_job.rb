# frozen_string_literal: true

class GenerateReportJob
  include Sidekiq::Job

  def perform(report_request_id)
    report_request = ReportRequest.find(report_request_id)

    generator = ReportRequests::GeneratorFactory.call(report_request)

    generator.generate
  end
end
