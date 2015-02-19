def debug
  begin
    p "flash alert: #{div('flash_alert').text}"
  rescue Capybara::ElementNotFound
    p "no flash alert"
  end
  begin
    p "flash notice: #{div('flash_notice').text}"
  rescue Capybara::ElementNotFound
    p "no flash notice"
  end
  p "current path: #{current_path}"
end

# FORM ---------------------------------------

def form(id=nil,i=-1) tag(:form,id,i) end
def tag(tag,id,i=-1)
  if id.nil?
    find(:css, tag.to_s)
  elsif i<0
    find(:css,"#{tag}##{id.to_s}")
  else
    all(:css,"#{tag}.#{id.to_s}")[i] 
  end
end
def value(s,i=0) 
  if s.instance_of? String
    ids = all(:css,"label",text:s).select{|e| e.text =~ /^#{s}\**$/}.map{|e| e[:for]}
    find_field(ids[i]).value 
  else
    find_field(s.to_s).value
  end
end
def have_cancel_button(s='Cancel')
  have_xpath("//input[@class='cancel' and @type='submit' and @value='#{s}']") 
end
def have_submit_button(s)
  #have_xpath("//input[@type='submit' and @class='button submit' and @value='#{s}']") 
  have_xpath("//input[@class='button submit' and @type='submit' and @value='#{s}']") 
end

# ERRORS -------------------------------------
def have_error(err,no=nil)
  err = I18n.t("errors.messages.#{err.to_s}",count:no) if err.instance_of? Symbol
  #have_css("p.inline-errors",:text=>err)
  have_css("span.error",:text=>err)
end
def have_blank_error; have_error(:blank) end
def have_confirmation_error
  have_error(:confirmation)
end
def have_duplication_error; have_error(:taken) end
def have_greater_than_error(no)
  have_error(:greater_than,no)
end
def have_greater_than_or_equal_to_error(no)
  have_error(:greater_than_or_equal_to,no)
end
def have_inclusion_error; have_error(:inclusion) end
def have_invalid_error; have_error(:invalid) end
def have_numericality_error
  have_error(:not_a_number)
end
def have_hint(s=nil)
  if s.nil?
    have_css("p.inline-hints")
  else
    have_css("p.inline-hints",:text=>s)
  end
end

# FLASH --------------------------------------
def have_flash(type,s="") 
  if s.empty?
    have_css("div#flash_#{type}")
  else
    have_css("div#flash_#{type}",:text=>s) 
  end
end
def have_alert(s=""); have_flash(:alert,s) end
def have_notice(s=""); have_flash(:notice,s) end
def have_deleted_notice_for(s)
  have_notice("Successfully deleted #{I18n.t(s)}.")
end


def have_image(s); have_xpath("//img[@alt='#{s}']") end
def have_a_table(s,i=-1)
  if i<0
    have_css("table##{s}")
  else
    have_xpath("//table[@class='#{s}'][#{i+1}]") 
  end
end

def have_title(s); have_css("h1",:text=>s) end
def have_h2(s); have_css("h2",:text=>s) end
def have_subtitle(s); have_css("h3",:text=>s) end

def li_id(s,i)
  first(:css, "li##{tag_ids(:li,s)[i]}")
end

def li(s,i=-1)
  return lis[s] if s.instance_of? Fixnum
  if i>=0
    all(:css, "li.#{tag_class(s,:li)}".rstrip)[i]
    #all(:css, "li.#{tag_class(s,:li)}")[i] #address 
    #all(:css, "li##{tag_id(s,:li)}")[i] #book
  elsif s.instance_of? Symbol
    #find(:css, "li##{tag_id(s,:li)}") if i<0
    all(:css, "li##{tag_id(s,:li)}")[i] #book
    #find(:css, "li##{tag_ids(:li,s)[i]}")
  elsif s.instance_of? String
    find(:css,"li##{tag_id(lbl_id(s),:li)}") if i<0
    #all(:css,"li##{tag_id(lbl_id(s),:li)}")[i]
  else
    #s.find(:css,'li') if i<0
    s.all(:css,'li')[i]
  end
end
def lis(s=nil)
  if s.nil?
    all(:css,"li") 
  else
    all(:css,"li##{tag_id(s,:li)}")
  end
end
def lis_no(s)
  tag_ids(:li,s).count
end
def ul(id=nil,i=-1) tag(:ul,id,i) end
def row(i,s=nil); table(s).all(:css,'tr')[i] end
def cell(row,col); row(row).all(:css,'td')[col] end

# TABLESMAP ----------------------------------

def tablemaps
  ret = []
  tables.each_index{|i| ret.push tablemap(nil,i)} 
  ret
end

def tableheader(id=nil)
  tbl = table(id,-1).all(:css,'tr').map{|e| e.all(:css,'th').map{|f| f.text.strip}}
  begin
    table(id,i).find(:css,'td')
    tbl.pop
  rescue
  end
  tbl.flatten
end
def tablemap(id=nil,i=-1)
  tbl = table(id,i).all(:css,'tr').map{|e| e.all(:css,'td').map{|f| f.text.strip}}
  begin
    table(id).find(:css,'th')
    tbl.shift
    #tbl.unshift table(id).first(:css,'tr').all(:css,'th').map{|e| e.text.strip}
  rescue
  end
  tbl
end
def tablerow(row,id=nil,i=-1); tablemap(id,i)[row] end
def tablecell(row,col,id=nil,i=-1); tablerow(row,id,i)[col] end

def table(id=nil,i=-1)
  if i<0
    if id.nil?
      find(:css,"table")
    else
      find(:css,"table##{id}")
    end
  else
    tables[i]
  end
end
def tables(s=nil)
  if s.nil?
    all(:css,'table')
  else
    all(:css,"table.#{s}")
  end
end
def tag_class(s,tag)
  all(:css,tag.to_s).map{|e| e[:class]}.select{|e| e =~ /#{s}/}.first
end
def tag_id(s,tag); tag_ids(tag).select{|e| e=~/#{s}/}.first end
def tag_ids(tag,s=nil); 
  if s.nil? 
    all(:css, tag.to_s).map{|e| e[:id]}
  else
    all(:css, tag.to_s).map{|e| e[:id]}.select{|e| e=~/#{s}/}
  end
end

# DIVS --------------------------------------

def have_form(id); have_css("form##{id}") end

def bottom_links; div('bottom_links') end
def top_links; div('top_links') end
def div(id,i=-1)
  if i.instance_of? Symbol
    id.find(:css,"div##{i}")
  elsif i<0
    find(:css,"div##{id.to_s}")
  else
    all(:css,"div.#{id.to_s}")[i] 
  end
end
def h2(id,i=-1) tag(:h2,id,i) end
def td(id,i=-1) tag(:td,id,i) end
def span(id,i=-1)
  if i<0
    find(:css,"span##{id.to_s}")
  else
    all(:css,"span.#{id.to_s}")[i] 
  end
end
def divs(s); all(:css, "div.#{s}") end
def forms(s); all(:css, "form.#{s}") end
def forms_id(s); all(:css, "form##{s}") end
def divs_no(s); divs(s).count end
def forms_no(s); forms(s).count end
def forms_id_no(s); forms_id(s).count end

def search_bar; div(:search_bar) end
def site_nav; div(:site_nav) end
def user_nav; div(:user_nav) end
def have_tag(tag,s,i=-1)
  if i<0
    have_css("#{tag}##{s}")
  else
    have_xpath("//#{tag}[@class='#{s}'][#{i+1}]")
  end
end
def have_div(s,i=-1) have_tag('div',s,i) end
def have_textarea(s,i=-1) have_tag('textarea',s,i) end
def have_bottom_link(s)
  have_css("div#bottom_links a",:text=>s)
end
def have_bottom_links; have_div('bottom_links') end
def have_link(s); have_css("a",:text=>s) end
def have_span(s,i=-1) have_tag('span',s,i) end
def have_fieldset(s,i=-1) have_tag('fieldset',s,i) end
def have_ul(s,i=-1) have_tag('ul',s,i) end

private
  def lbl_id(s) 
    find(:css,'label',:text=>s)[:for]
  end
