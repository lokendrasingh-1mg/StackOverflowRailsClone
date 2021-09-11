# Provides add_timestamp which adds timestamp to record
# insert_all_normalized: performs bulk insert of records after normalizing them
module Insertable
  extend ActiveSupport::Concern

  class_methods do
    def add_timestamp(record)
      time = Time.now.utc

      record[:created_at] = time
      record[:updated_at] = time
    end

    # Executes insert_all on model after normalizing all the records
    def insert_all_normalized(records, options = { returning: [:id] })
      normalized = normalize(records)

      begin
        result = insert_all(normalized, options)
      rescue ActiveRecord::StatementInvalid => e
        result = e
      end
      result
    end
  end
end
