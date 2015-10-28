module Penis; end
class SoundUploader; end
module ActiveRecord
  class Base 
    def self.mount_uploader *args; end
  end
end
require './app/models/glossary'
