# Once

class ActionController::Base
  before_filter :clear_once_actions

  def clear_once_actions
    ActionView::Helpers::Once::clear_actions
  end
end

module ActionView
  module Helpers
    class Once
      @@actions = {}

      def self.do(name, &block)
        if !self.done?(name)
          self.done(name)
          if Rails::VERSION::MAJOR == 3
            yield 
            nil
          else
            return yield
          end
        end
        nil
      end

      def self.done(name)
        @@actions[name] = true
      end

      def self.done?(name)
        @@actions[name]
      end

      def self.clear_actions
        @@actions = {}
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
