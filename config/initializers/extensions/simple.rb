require 'capybara' 

module Capybara
  module Node
    class Simple
      def h1; find("h1") end
    end
  end
end
