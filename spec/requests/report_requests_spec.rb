# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Report Requests API", type: :request do
  path "/report_requests" do
    post "Creates a report request" do
      tags "Report Requests"
      consumes "application/json"
      produces "application/json"

      parameter name: :report_request,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    report_type: {
                      type: :string,
                      enum: %w[postback_response click]
                    },
                    file_format: {
                      type: :string,
                      enum: %w[csv xlsx]
                    }
                  },
                  required: %w[report_type file_format]
                }

      response "201", "report created" do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 status: { type: :string },
                 report_type: { type: :string },
                 file_format: { type: :string },
                 file_path: {
                   type: :string,
                   nullable: true
                 },
                 created_at: {
                   type: :string,
                   format: :"date-time"
                 },
                 updated_at: {
                   type: :string,
                   format: :"date-time"
                 }
               }

        let(:report_request) do
          {
            report_type: "postback_response",
            file_format: "csv"
          }
        end

        run_test!
      end
    end

    get "Lists report requests" do
      tags "Report Requests"
      produces "application/json"

      response "200", "list of report requests" do
        run_test!
      end
    end
  end
end
