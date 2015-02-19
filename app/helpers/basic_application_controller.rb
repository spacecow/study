module BasicApplicationController
  def added_to_cart(o,name,i=1)
    if i==1
      succ("added_to_cart.one", o:pl(o,i), name:name, count:i)
    else
      succ("added_to_cart.other", o:pl(o,i), name:name, count:i)
    end
  end
  def alertify(s) jt("alerts.#{s}") end
  def canceled(s) succ(:canceled,:o=>jt(s)) end
  def confirmed(s) succ(:confirmed,:o=>jt(s)) end
  def created(o,i=nil)
    i ? succ_no(:created,o,i) : succ(:created,o:pl(o,1))
  end
  def created_adv(o,name); succ_adv(:created,o,name) end
  def created_state(mdl,state)
    succ(:created_state,:o=>jt(mdl),:state=>jt(state).downcase)
  end
  def deleted(s,i=1) succ(:deleted,:o=>pl(s,i)) end
  def deleted_adv(o,name); succ_adv(:deleted,o,name) end
  def emptied(s) succ(:emptied,:o=>jt(s)) end
  def english?; get_language == :en end
  def error(s,*opt) jt("errors.#{s}",*opt) end
  def errors(s,*opt) jt("errors.messages.#{s}",*opt) end
  def get_language; I18n.locale end
  def jt(s,*opt)
    #TRANSLATION_LOG.debug s
    I18n.t(s,opt.first)
  end
  def mess(s,*opt) jt("messages.#{s}",*opt) end
  def notify(s) jt("notices.#{s}") end
  def not_created(o)
    jt("alerts.not_created", o:pl(o,1))
  end
  def pl(s,i=2)
    #if i==1
    #  t("#{s}.one",count:1)
    #else
    #  t("#{s}",count:i)
    #end
    if i==1 
      jt("#{s}.one",count:1) =~ /translation missing/ ? jt(s) : jt("#{s}.one",count:1)
    else
      if english?
        jt("#{s}.other",count:i)
      else
        jt("#{s}.other",count:1)
      end
    end
  end
  def removed_from_cart(o,name,i=1)
    if i==1
      succ("removed_from_cart.one", o:pl(o,i), name:name, count:i)
    else
      succ("removed_from_cart.other", o:pl(o,i), name:name, count:i)
    end
  end
  def saved(o,i=nil)
    i ? succ_no(:saved,o,i) : succ(:saved,o:pl(o,1))
  end
  def updated(o) succ(:updated,o:pl(o,1)) end
  def updated_adv(o,name); succ_adv(:updated,o,name) end

  def current_user
    @current_user ||= User.find(session_userid) if session_userid
  end

  def session_original_url(*opt)
    if opt.present? 
      session[:original_url] = opt.first
    else
      session[:original_url]
    end
  end

  def session_userid(*opt)
    if opt.present? 
      session[:userid] = opt.first 
    else
      session[:userid] 
    end
  end

  private

    def succ(lbl,*opt)
      jt("successes.#{lbl}",opt.first) 
    end
    def succ_adv(lbl,o,name)
      jt("successes_adv.#{lbl}", o:pl(o,1), name:name)
    end
    def succ_no(lbl,o,i)
      if i==1
        jt("successes_no.#{lbl}.one", o:pl(o,i), count:i)
      else
        jt("successes_no.#{lbl}.other", o:pl(o,i), count:i)
      end
    end
end
