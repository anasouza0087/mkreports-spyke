# frozen_string_literal: true

module ReportRequests
  class RespostaPostbackGenerator < BaseGenerator
    def generate
      report_request.processing!

      sleep 3

      report_request.completed!
    rescue StandardError
      report_request.error!
    end
  end
end
