module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def present(array, klass=nil)
    if array.instance_of? Array
      object = array.shift
      parent = array.shift
      grandparent = array.shift
    else
      object = array
      parent = nil
      grandparent = nil
    end
    if object.class.superclass.superclass.to_s == "ActiveRecord::Base"
      klass ||= "#{object.class.superclass}Presenter".constantize
    else
      klass ||= "#{object.instance_of?(Class) ? object : object.class}Presenter".constantize
    end
    presenter = klass.new(object, parent, grandparent, self)
    yield presenter if block_given?
    presenter
  end

  def pl(s,i=2)
    if i==1
      t("#{s}.one",count:1)
    else
      t("#{s}",count:i)
    end
    #if i==1 
    #  jt("#{s}.one",count:1) =~ /translation missing/ ? jt(s) : jt("#{s}.one",count:1)
    #else
    #  if english?
    #    jt("#{s}.other",count:i)
    #  else
    #    jt("#{s}.other",count:1)
    #  end
    #end
  end
end
