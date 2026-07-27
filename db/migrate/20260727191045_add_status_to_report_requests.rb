class AddStatusToReportRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :report_requests, :status, :integer, default: 0, null: false
  end
end