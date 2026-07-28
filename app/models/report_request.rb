class ReportRequest < ApplicationRecord
  enum :status,
       {
         pending: 0,
         processing: 1,
         completed: 2,
         error: 3
       }

  enum :report_type, {
    postback_response: 0,
    click: 1
  }

  enum :file_format, {
    csv: 0,
    xlsx: 1
  }

end