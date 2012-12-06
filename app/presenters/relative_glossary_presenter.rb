class RelativeGlossaryPresenter < BasePresenter
  presents :relative

  def actions
    h.content_tag :span, class:'actions' do
      delete_link
    end
  end

  def content
    h.link_to relative.content(@parent), relative.secondary(@parent)
  end

  def delete_link
    dcase = @object.class.to_s.underscore.downcase
    h.link_to h.t(:delete), h.send("#{dcase}_path",@object,main:@parent), method: :delete, data:{confirm:h.sure?} if h.can? :destroy, @object 
  end
end
