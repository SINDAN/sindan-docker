class StatusesController < ApplicationController
  before_action :authenticate_user!

  # GET /status
  # GET /status.json
  def index
    @ssid = params[:ssid]

    term = 10
    count = 12
    time = Time.zone.now
    @time_list = ((count - 1) * term).step(0, -1 * term).map { |i| time - i.minutes }
    @layers = DiagnosisLog.layer_defs.keys.reverse

    @target_logs = DiagnosisLog.occurred_after(time - (term * count).minutes)

    unless @ssid.blank?
      @target_logs = @target_logs.ssid_by(@ssid)
    end

    @diagnosis_logs = @target_logs.fail
  end
end
