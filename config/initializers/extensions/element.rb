require 'capybara' 

module Capybara
  module Node
    class Element < Base
      def tag(tag,id,i=-1)
        if i<0
          find(:css,"#{tag}##{id.to_s}") 
        else
          all(:css,"#{tag}.#{id.to_s}")[i]
        end
      end
      def div(id,i=-1) tag(:div,id,i) end
      def divs(s); all(:css, "div.#{s}") end
      def divs_no(s); divs(s).count end
      def divs_text(s)
        divs(s).map{|e| e.text.strip}.join(', ')
      end
      def h2; find(:css, "h2") end
      def li(s,i=-1)
        if s.instance_of? Fixnum 
          lis[s]
        elsif i<0
          find(:css,"li##{s}") 
        else
          all(:css,"li.#{s}")[i]
        end
      end
      def lis_no(s=nil); lis(s).count end
      def options(lbl)
        find_field(lbl).all(:css,"option").map{|e| e.text.blank? ? "BLANK" : e.text}.join(', ')
      end
      def selected_value(s)
        begin
          find_field(s).find(:xpath,"//option[@selected='selected']").text
        rescue
          nil 
        end
      end
      def rows_no; all(:css,'tr').count end
      def span(id,i=-1)
        if i<0
          find(:css,"span##{id.to_s}")
        else
          all(:css,"span.#{id.to_s}")[i] 
        end
      end
      def tables_no(s); tables(s).count end
      def ul(id,i=-1) tag(:ul,id,i) end

      private

        def lis(s=nil)
          if s.nil?
            all('li')
          else
            all(:css, "li.#{s}")
          end
        end
    end
  end
end
