class PagesController < ApplicationController
  def index
    if current_franchise.present?
      @plans   = current_franchise.plans.visibles.order('price ASC').limit(3)
      @contact = current_franchise.contacts.new

      @banner   = current_franchise.banners.where(locale: I18n.locale).first
      @banner ||= current_franchise.banners.where(locale: 'en').first

      @video   = current_franchise.videos.where(locale: I18n.locale).first
      @video ||= current_franchise.videos.where(locale: 'en').first
    else
      @plans = Plan.master.visibles.order('price ASC').limit(3)
      @contact = Contact.new

      @banner   = Banner.master.where(locale: I18n.locale).first
      @banner ||= Banner.master.where(locale: 'en').first

      @video   = Video.master.where(locale: I18n.locale).first
      @video ||= Video.master.where(locale: 'en').first
    end
  end
end
