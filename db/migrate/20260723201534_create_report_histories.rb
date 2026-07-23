class CreateReportHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :report_histories do |t|
      t.timestamps
    end
  end
end
