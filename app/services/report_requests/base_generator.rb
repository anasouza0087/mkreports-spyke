# frozen_string_literal: true

module ReportRequests
  class BaseGenerator
    attr_reader :report_request

    def initialize(report_request)
      @report_request = report_request
    end

    def generate
      raise NotImplementedError
    end
  end
end
