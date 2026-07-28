# frozen_string_literal: true

class ReportRequestsController < ApplicationController
  def index
    report_requests = ReportRequest.all
    render json: report_requests
  end

  def create
    report_request = ReportRequest.create!(
      report_request_params.merge(status: :pending)
    )

    GenerateReportJob.perform_async(report_request.id)
    render json: report_request, status: :created
  end

  private

  def report_request_params
    params.permit(:report_type, :file_format)
  end
end
