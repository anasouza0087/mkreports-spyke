class CreateReportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :report_requests do |t|
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
