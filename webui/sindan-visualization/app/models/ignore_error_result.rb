class IgnoreErrorResult < ApplicationRecord
  validates_presence_of :ssid
  validates_uniqueness_of :ssid

  default_scope { order(:ssid) }

  scope :ssid_by, ->(ssid) { where(ssid: ssid) }

  concerning :IgnoreLogTypes do
    included do
      serialize :ignore_log_types, Array

      def self.ignore_log_types_by_ssid(ssid)
        self.ssid_by(ssid).first.try(:ignore_log_types)
      end
    end
  end
end
