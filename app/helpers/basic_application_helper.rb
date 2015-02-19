module BasicApplicationHelper
  def add(o,i=1); labels(:add,o,i) end
  def add_to(s); jt('labels.add_to',:o=>jt(s)) end
  def cancel(o,i=1) labels(:cancel,o,i) end
  def confirm(o,i=1) labels(:confirm,o,i) end
  def create(o,i=1) labels(:create,o,i) end
  def crop(o,i=1) labels(:crop,o,i) end
  def edit(o,i=1) labels(:edit,o,i) end
  def empty(s); jt('labels.empty',:o=>jt(s)) end
  def formtitle(mdl,tag="h3")
    s = mdl.class.to_s.underscore.to_sym
    minititle(mdl.new_record? ? new(s) : edit(s))
  end
  def ft(s); jt("formtastic.labels.#{s.to_s}") end
  def mess(s,*opt) t("messages.#{s}",*opt) end
  def minititle(s); raw "<h2>#{s}</h2>" end
  def new(o,i=1) labels(:new,o,i) end
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
  def remove(o,i=1) labels(:remove,o,i) end
  def submit(f,mdl)
    s = mdl.class.to_s.downcase
    f.submit mdl.new_record? ? create(s) : update(s) 
  end
  def subminititle(s); raw "<h4>#{s}</h4>" end
  def subtitle(s); raw "<h3>#{s}</h3>" end
  def sure?; mess(:sure?) end
  def title(s)
    content_for(:title){ s.to_s }
    raw "<h1>#{s}</h1>"
  end
  def update(o,i=1) labels(:update,o,i) end

  def jtime_ago_in_words(from_time, include_seconds = false)
    jdistance_of_time_in_words(from_time, Time.now, include_seconds)
  end 

  private

    def labels(lbl,o,i)
      obj = o.instance_of?(Symbol) ? pl(o,i) : o 
      t("labels.#{lbl}", o:obj)
    end

    def jdistance_of_time_in_words(from_time, to_time = 0, include_seconds = false, options = {})
      from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      distance_in_minutes = (((to_time - from_time).abs)/60).round
      distance_in_seconds = ((to_time - from_time).abs).round

      I18n.with_options :locale => options[:locale], :scope => :'datetime.distance_in_words' do |locale|
        case distance_in_minutes
          when 0..1
            return distance_in_minutes == 0 ?
                   locale.t("less_than_x_minutes.one", :count => 1) :
                   locale.t("x_minutes.one", :count => distance_in_minutes) unless include_seconds

            case distance_in_seconds
              when 0..4   then locale.t "less_than_x_seconds.other", :count => 5
              when 5..9   then locale.t "less_than_x_seconds.other", :count => 10
              when 10..19 then locale.t "less_than_x_seconds.other", :count => 20
              when 20..39 then locale.t :half_a_minute
              when 40..59 then locale.t "less_than_x_minutes.one", :count => 1
              else             locale.t "x_minutes.one",           :count => 1
            end

          when 2..44           then locale.t "x_minutes.other",      :count => distance_in_minutes
          when 45..89          then locale.t "about_x_hours.one",  :count => 1
          when 90..1439        then locale.t "about_x_hours.other",  :count => (distance_in_minutes.to_f / 60.0).round
          when 1440..2519      then locale.t "x_days.one",         :count => 1
          when 2520..43199     then locale.t "x_days.other",         :count => (distance_in_minutes.to_f / 1440.0).round
          when 43200..86399    then locale.t "about_x_months.one", :count => 1
          when 86400..525599   then locale.t "x_months.other",       :count => (distance_in_minutes.to_f / 43200.0).round
          else
            fyear = from_time.year
            fyear += 1 if from_time.month >= 3
            tyear = to_time.year
            tyear -= 1 if to_time.month < 3
            leap_years = (fyear > tyear) ? 0 : (fyear..tyear).count{|x| Date.leap?(x)}
            minute_offset_for_leap_year = leap_years * 1440
            # Discount the leap year days when calculating year distance.
            # e.g. if there are 20 leap year days between 2 dates having the same day
            # and month then the based on 365 days calculation
            # the distance in years will come out to over 80 years when in written
            # english it would read better as about 80 years.
            minutes_with_offset         = distance_in_minutes - minute_offset_for_leap_year
            remainder                   = (minutes_with_offset % 525600)
            distance_in_years           = (minutes_with_offset / 525600)
            if remainder < 131400
              if distance_in_years == 1
                locale.t("about_x_years.one",  :count => 1)
              else
                locale.t("about_x_years.other",  :count => distance_in_years)
              end
            elsif remainder < 394200
              if distance_in_years == 1
                locale.t("over_x_years.one",   :count => distance_in_years)
              else
                locale.t("over_x_years.other",   :count => distance_in_years)
              end
            else
              locale.t("almost_x_years.other", :count => distance_in_years + 1)
            end
        end
      end
    end

end
