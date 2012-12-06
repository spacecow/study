class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def h; @template end

  def clear_div
    "<div class='clear'></div>".html_safe
  end

  def new_link
    dcase = @object.to_s.downcase
    h.link_to h.new(dcase.to_sym), h.send("new_#{dcase}_path") if h.can? :new, @object
  end
  def edit_link
    dcase = @object.class.to_s.downcase
    h.link_to h.t(:edit), h.send("edit_#{dcase}_path", @object) if h.can? :edit, @object 
  end

  class << self
    def presents(name)
      define_method(name) do
        @object
      end
    end
  end
end
