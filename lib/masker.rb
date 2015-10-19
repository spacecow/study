class Masker

  def self.combine arr
    arr.
      map{|s| s.split}.transpose.
      map{|a| a.sort_by{|s| s.count('*')}.last}.
      join(" ")
  end

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
      s.sub w, w.gsub(/\w/,'*')
    end

end
