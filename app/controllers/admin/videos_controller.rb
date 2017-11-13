class Admin::VideosController < Admin::AdminController
  include AdminPolicies

  set_tab :videos

  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    if current_franchise.present?
      @videos = current_franchise.videos
    end

    @videos ||= Video.all
    @videos   = @videos.includes(:franchise).page(params[:page])

    respond_with @videos
  end

  def new
    @video = Video.new
    respond_with @video
  end

  def edit
    respond_with @video
  end

  def create
    if current_franchise.present?
      @video = current_franchise.videos.new(videos_params)
    else
      @video = Video.new(videos_params)
    end

    flash[:notice] = t('flash_messages.created', model: Video.model_name.human) if @video.save
    respond_with @video, :location => admin_videos_url
  end

  def update
    flash[:notice] = t('flash_messages.updated', model: Video.model_name.human) if @video.update_attributes(videos_params)
    respond_with @video, :location => admin_videos_url
  end

  def destroy
    flash[:notice] = t('flash_messages.deleted', model: Video.model_name.human) if @video.destroy
    respond_with @video, :location => admin_videos_url
  end

  protected

    def set_video
      if current_franchise.present?
        @video = current_franchise.videos.find(params[:id])
      else
        @video = Video.find(params[:id])
      end
    end

    def videos_params
      params.require(:video).permit(
        :html, :locale, :external_link
      )
    end
end
