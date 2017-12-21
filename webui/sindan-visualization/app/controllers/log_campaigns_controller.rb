# coding: utf-8
class LogCampaignsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_log_campaign, only: [:show, :all, :log, :error, :edit, :update, :destroy]

  # GET /log_campaigns
  # GET /log_campaigns.json
  def index
    @log_campaigns = LogCampaign.all.page(params[:page])
  end

  # GET /log_campaigns/search
  # GET /log_campaigns/search.json
  def search
    @log_campaign_list = LogCampaign.all

    # search keywork
    @keyword = params[:keyword]
    keywords = []

    unless @keyword.nil?
      keywords = @keyword.gsub("　", " ").split(" ")
    end

    # NOTE: serach target: log_campaign all column without xxx_at
    shared_context = Ransack::Context.for(LogCampaign)
    shared_conditions = Array.new

    keywords.each do |keyword|
      search = LogCampaign.ransack(
        { log_campaign_uuid_or_mac_addr_or_os_or_ssid_cont: keyword }, context: shared_context
      )

      shared_conditions << Ransack::Visitor.new.accept(search.base)
    end

    @log_campaign_list = @log_campaign_list.joins(shared_context.join_sources).where(shared_conditions.reduce(&:and))

    # search Datetime from / to
    @datetime_from = DateTime.parse(params[:datetime_from]) rescue nil
    @datetime_to = DateTime.parse(params[:datetime_to]) rescue nil

    @log_campaign_list = @log_campaign_list.occurred_after(@datetime_from) unless @datetime_from.nil?
    @log_campaign_list = @log_campaign_list.occurred_before(@datetime_to) unless @datetime_to.nil?

    @log_campaigns = @log_campaign_list.page(params[:page])
  end

  # GET /log_campaigns/1
  # GET /log_campaigns/1.json
  def show
    @diagnosis_logs = @log_campaign.diagnosis_logs.log
  end

  # GET /log_campaigns/1/all
  # GET /log_campaigns/1/all.json
  def all
    @diagnosis_logs = @log_campaign.diagnosis_logs

    render action: :show
  end

  # GET /log_campaigns/1/log
  # GET /log_campaigns/1/log.json
  def log
    @diagnosis_logs = @log_campaign.diagnosis_logs.log

    render action: :show
  end

  # GET /log_campaigns/1/error
  # GET /log_campaigns/1/error.json
  def error
    @diagnosis_logs = @log_campaign.diagnosis_logs.fail

    render action: :show
  end

  # GET /log_campaigns/new
  def new
    @log_campaign = LogCampaign.new
  end

  # GET /log_campaigns/1/edit
  def edit
  end

  # POST /log_campaigns
  # POST /log_campaigns.json
  def create
    @log_campaign = LogCampaign.new(log_campaign_params)

    respond_to do |format|
      if @log_campaign.save
        format.html { redirect_to @log_campaign, notice: 'Log campaign was successfully created.' }
        format.json { render :show, status: :created, location: @log_campaign }
      else
        format.html { render :new }
        format.json { render json: @log_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_campaigns/1
  # PATCH/PUT /log_campaigns/1.json
  def update
    respond_to do |format|
      if @log_campaign.update(log_campaign_params)
        format.html { redirect_to @log_campaign, notice: 'Log campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_campaign }
      else
        format.html { render :edit }
        format.json { render json: @log_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_campaigns/1
  # DELETE /log_campaigns/1.json
  def destroy
    @log_campaign.destroy
    respond_to do |format|
      format.html { redirect_to log_campaigns_url, notice: 'Log campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log_campaign
      @log_campaign = LogCampaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_campaign_params
      params.require(:log_campaign).permit(:log_campaign_uuid, :ssid, :mac_addr, :os, :occurred_at)
    end
end
