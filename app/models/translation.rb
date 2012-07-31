class Translation < ActiveRecord::Base
  belongs_to :locale

  attr_accessible :key, :locale_token, :value
  attr_reader :locale_token

  validates :key, presence:true
  validates :value, presence:true
  validates :locale, presence:true
  
  def locale_token=(token)
    self.locale_id = Locale.id_from_token(token)
  end 
end
