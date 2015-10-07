class Masker

  def self.mask s, arr
    if arr.kind_of? Array
      arr.
        map{|w| mask_word s, w}.
        sort_by{|mask| mask.count('*')}.
        last
    elsif arr.kind_of? String
      mask_word s, arr 
    end
  end

  private

    def self.mask_word s, w
      s.sub w, "*"*w.size
    end

end
