class IgnoreErrorResultsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_ignore_error_result, only: [:show, :edit, :update, :destroy]

  concerning :BreadcrumbFeature do
    included do
      before_action only: [:index, :show, :new, :create, :edit, :update] do |controller|
        add_breadcrumb I18n.t('views.settings.index.title'), ''
        add_breadcrumb I18n.t('views.ignore_error_results.index.title'), ignore_error_results_path
      end

      before_action only: [:show, :edit, :update] do |controller|
        add_breadcrumb "#{@ignore_error_result.ssid}", ignore_error_result_path(@ignore_error_result)
      end

      before_action only: [:new, :create] do |controller|
        add_breadcrumb I18n.t('views.ignore_error_results.new.title'), new_ignore_error_result_path
      end

      before_action only: [:edit, :update] do |controller|
        add_breadcrumb I18n.t('views.ignore_error_results.edit.title'), edit_ignore_error_result_path(@ignore_error_result)
      end
    end
  end

  # GET /ignore_error_results
  # GET /ignore_error_results.json
  def index
    @ignore_error_results = IgnoreErrorResult.all
  end

  # GET /ignore_error_results/1
  # GET /ignore_error_results/1.json
  def show
  end

  # GET /ignore_error_results/new
  def new
    @ignore_error_result = IgnoreErrorResult.new
  end

  # GET /ignore_error_results/1/edit
  def edit
  end

  # POST /ignore_error_results
  # POST /ignore_error_results.json
  def create
    @ignore_error_result = IgnoreErrorResult.new(ignore_error_result_params)

    respond_to do |format|
      if @ignore_error_result.save
        format.html { redirect_to @ignore_error_result, notice: 'Ignore error result was successfully created.' }
        format.json { render :show, status: :created, location: @ignore_error_result }
      else
        format.html { render :new }
        format.json { render json: @ignore_error_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ignore_error_results/1
  # PATCH/PUT /ignore_error_results/1.json
  def update
    respond_to do |format|
      if @ignore_error_result.update(ignore_error_result_params)
        format.html { redirect_to @ignore_error_result, notice: 'Ignore error result was successfully updated.' }
        format.json { render :show, status: :ok, location: @ignore_error_result }
      else
        format.html { render :edit }
        format.json { render json: @ignore_error_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ignore_error_results/1
  # DELETE /ignore_error_results/1.json
  def destroy
    @ignore_error_result.destroy
    respond_to do |format|
      format.html { redirect_to ignore_error_results_url, notice: 'Ignore error result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ignore_error_result
      @ignore_error_result = IgnoreErrorResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ignore_error_result_params
      params.require(:ignore_error_result).permit(:ssid, ignore_log_types: [])
    end
end
