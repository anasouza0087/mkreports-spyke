class AddFileFormatToReportRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :report_requests, :file_format, :integer
  end
end
