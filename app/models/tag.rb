class Tag < ApplicationRecord
  include Insertable

  has_and_belongs_to_many :questions

  def self.normalize(records)
    records.each do |record|
      add_timestamp(record)
    end
  end
end
