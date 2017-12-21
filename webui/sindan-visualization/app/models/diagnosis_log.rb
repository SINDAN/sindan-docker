# coding: utf-8
class DiagnosisLog < ApplicationRecord
  belongs_to :log_campaign, foreign_key: :log_campaign_uuid, primary_key: :log_campaign_uuid, touch: true

  enum result: {
         fail: 0,
         success: 1,
         information: 10,
       }

  cattr_reader :layer_defs
  @@layer_defs = {
    datalink: 'データリンク層',
    interface: 'インタフェース設定層',
    localnet: 'ローカルネットワーク層',
    globalnet: 'グローバルネットワーク層',
    dns: '名前解決層',
    web: 'ウェブアプリケーション層',
  }

  cattr_reader :log_type_defs
  @@log_type_defs = [
    "v4http_srv", "v6http_srv", "v6trans_aaaa_namesrv", "v4trans_aaaa_namesrv", "v4trans_a_namesrv",
    "v6path_srv", "v6rtt_srv", "v4pmtu_srv", "v4rtt_srv", "v4alive_srv",
    "v4path_srv", "v6alive_router", "v4alive_namesrv", "v4rtt_namesrv", "v4alive_router",
    "v4rtt_router", "v6routers", "prefixlen", "ra_prefix_flags", "v6addrs",
    "v6autoconf", "ra_prefixes", "ra_flags", "v4ifconf", "v6ifconf",
    "v4nameservers", "v4routers", "v4autoconf", "v4addr", "netmask",
    "v6lladdr", "rate", "channel", "ifstatus", "ssid",
    "iftype", "rssi", "bssid", "noise", "ifmtu",
  ]

  default_scope { order(occurred_at: :desc) }

  scope :log, lambda {
    condition = arel_table[:result].eq(DiagnosisLog.results[:fail])
                .or(arel_table[:result].eq(DiagnosisLog.results[:success]))
    where(condition)
  }
  scope :occurred_before, ->(time) { where(arel_table[:occurred_at].lt(time)) }
  scope :occurred_after, ->(time) { where(arel_table[:occurred_at].gt(time)) }
  scope :layer_by, ->(layer) { where(layer: layer) }
  scope :ssid_by, ->(ssid) { includes(:log_campaign).references(:log_campaign).where(log_campaigns: { ssid: ssid }) }

  def self.layer_label(layer)
    if !layer.blank? && self.layer_defs.keys.include?(layer.to_sym)
      self.layer_defs[layer.to_sym]
    else
      layer
    end
  end

  def layer_label
    DiagnosisLog.layer_label(self.layer)
  end

  def result_label
    if self.result.nil?
      ''
    end

    ignore_log_types = IgnoreErrorResult.ignore_log_types_by_ssid(self.log_campaign.try(:ssid)) || Array.new

    if self.fail? && ignore_log_types.include?(self.log_type)
      'warning'
    else
      self.result
    end
  end

  def log
    "#{self.layer_label}(#{self.log_group}) #{self.log_type}<br />#{self.detail}"
  end

  def self.date_list
    Rails.cache.fetch("date_list") do
      DiagnosisLog.pluck(:occurred_at).map{ |occurred_at| occurred_at.to_date.to_s unless occurred_at.blank? }.uniq
    end
  end

  # for ransacker
  ransacker :occurred_at do
    Arel.sql('date(occurred_at)')
  end
end
