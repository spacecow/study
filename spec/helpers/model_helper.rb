module ActiveRecord
  class Base
    def self.attr_accessible *args; end
    def self.belongs_to s; end
    def self.has_many *args; end
    def self.after_save s; end
    def self.validates *args; end
  end
end
