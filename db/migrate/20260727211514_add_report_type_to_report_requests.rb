class AddReportTypeToReportRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :report_requests, :report_type, :integer
  end
end
