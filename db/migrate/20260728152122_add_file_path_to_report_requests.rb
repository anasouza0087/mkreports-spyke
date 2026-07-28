class AddFilePathToReportRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :report_requests, :file_path, :string
  end
end
