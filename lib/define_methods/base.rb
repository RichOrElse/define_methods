module DefineMethods
  class Base < ::Module
    def initialize(*names, &block)
      define_methods(*names, &@@each_does)
      super(&block)
    end

    def inspect
      base = [self, self.class, DefineMethods].find(&:name)
      "#{base.name}[%s]" % defined_methods.join(' ')
    end

    class << self
      def each!(&does)
        @@each_does = does
        self
      end

      def each(&does)
        Class.new(self).each!(&does)
      end

      def inherited(base)
        base.include DefineMethods
      end
    end
  end
end
