# Once
module ActionView
  module Helpers
    class Once
      @@actions = {}

      def self.do(name, &block)
        if !self.done?(name)
          self.done(name)
          return yield
        end
        nil
      end

      def self.done(name)
        @@actions[name] = true
      end

      def self.done?(name)
        @@actions[name]
      end
    end

    def once(name, &block)
      Once::do(name, &block)
    end

    def once_done?(name)
      Once::done?(name)
    end

    def once_done(name)
      Once::done(name)
    end
  end
end
