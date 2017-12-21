class DiagnosisLogsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_diagnosis_log, only: [:show, :edit, :update, :destroy]

  # GET /diagnosis_logs
  # GET /diagnosis_logs.json
  def index
    if params[:date].nil?
      @diagnosis_logs = DiagnosisLog.all

    else
      @date = Date.parse(params[:date])
      @search = DiagnosisLog.search(occurred_at_date_eq: @date)
      @diagnosis_logs = @search.result(distinct: true)
    end

    @diagnosis_logs = @diagnosis_logs.page(params[:page])
  end

  # GET /diagnosis_logs/1
  # GET /diagnosis_logs/1.json
  def show
  end

  # GET /diagnosis_logs/new
  def new
    @diagnosis_log = DiagnosisLog.new
  end

  # GET /diagnosis_logs/1/edit
  def edit
  end

  # POST /diagnosis_logs
  # POST /diagnosis_logs.json
  def create
    @diagnosis_log = DiagnosisLog.new(diagnosis_log_params)

    respond_to do |format|
      if @diagnosis_log.save
        format.html { redirect_to @diagnosis_log, notice: 'Diagnosis log was successfully created.' }
        format.json { render :show, status: :created, location: @diagnosis_log }
      else
        format.html { render :new }
        format.json { render json: @diagnosis_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagnosis_logs/1
  # PATCH/PUT /diagnosis_logs/1.json
  def update
    respond_to do |format|
      if @diagnosis_log.update(diagnosis_log_params)
        format.html { redirect_to @diagnosis_log, notice: 'Diagnosis log was successfully updated.' }
        format.json { render :show, status: :ok, location: @diagnosis_log }
      else
        format.html { render :edit }
        format.json { render json: @diagnosis_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnosis_logs/1
  # DELETE /diagnosis_logs/1.json
  def destroy
    @diagnosis_log.destroy
    respond_to do |format|
      format.html { redirect_to diagnosis_logs_url, notice: 'Diagnosis log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis_log
      @diagnosis_log = DiagnosisLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diagnosis_log_params
      params.require(:diagnosis_log).permit(:layer, :log_group, :log_type, :log_campaign_uuid, :result, :detail, :occurred_at)
    end
end
