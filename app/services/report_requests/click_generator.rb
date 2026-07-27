# frozen_string_literal: true

module ReportRequests
  class ClickGenerator < BaseGenerator
    def generate
      report_request.processing!
      report_request.completed!
    end
  end
end
