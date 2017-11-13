class Admin::JobsController < Admin::AdminController
  include AdminPolicies

  set_tab :stores

  before_action :set_store, except: [:download, :retry]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :retry]

  def index
    @jobs = @store.jobs.order('created_at DESC').page(params[:page])
  end

  def new
    @job = @store.jobs.build(name: 'Import')
  end

  def show
  end

  def edit
  end

  def create
    @job = @store.jobs.build(jobs_params)

    flash[:notice] = t('flash_messages.created', model: Job.model_name.human) if @job.save
    respond_with @job, :location => admin_store_jobs_url(@store)
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Job.model_name.human) if @job.update_attributes(jobs_params)
    respond_with @job, :location => admin_store_jobs_url(@store)
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Job.model_name.human) if @job.destroy
    respond_with @job, :location => admin_store_jobs_url(@store)
  end

  def download
    send_file "#{ Rails.root }/public/sample.csv", filename: 'sample.csv', type: 'text/csv'
  end

  def retry
    if @job.update_attributes(closed: false, success: false)
      @job.set_worker

      flash[:notice] = t('flash_messages.job_retry')
    end

    redirect_to admin_store_jobs_url(@job.store)
  end

  protected

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def jobs_params
      params.require(:job).permit(
        :file, :name, :import_type
      )
    end
end
