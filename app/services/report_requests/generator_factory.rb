# frozen_string_literal: true

module ReportRequests
  class GeneratorFactory
    def self.call(report_request)
      case report_request.report_type
      when "postback_response"
        RespostaPostbackGenerator.new(report_request)
      when "click"
        ClickGenerator.new(report_request)
      else
        raise "Generator not found"
      end
    end
  end
end
