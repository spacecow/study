class TranslationsController < ApplicationController
  #load_and_authorize_resource
  #skip_load_resource :only => :index

  def index
    @translation = Translation.new
    @translations = TRANSLATION_STORE
  end

  def create
    if @translation.valid?
      I18n.backend.store_translations(@translation.locale.name, {@translation.key => @translation.value}, :escape => false)
      redirect_to translations_path
    else
      @translation.errors.add(:locale_token,@translation.errors[:locale]) if @translation.errors[:locale]
      @translations = TRANSLATION_STORE
      render :index
    end
  end

  def update_multiple
    (params[:en]||{}).each do |key,value|
      I18n.backend.store_translations(value[:locale], {value[:key] => value[:value]}, :escape => false) unless value[:value].blank?
    end
    (params[:ja]||{}).each do |key,value|
      I18n.backend.store_translations(value[:locale], {value[:key] => value[:value]}, :escape => false) unless value[:value].blank?
    end
    redirect_to translations_path
  end
end
