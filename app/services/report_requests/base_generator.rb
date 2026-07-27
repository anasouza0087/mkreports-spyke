# frozen_string_literal: true

module ReportRequests
  class BaseGenerator

    def initialize(report_request)
      @report_request = report_request
    end

    def generate
      raise NotImplementedError
    end

    private

    attr_reader :report_request
  end
end
