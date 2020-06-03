require "define_methods/version"
require "define_methods/base"

module DefineMethods
  def define_methods(*method_names, &block)
    method_names.map { |name| define_method(name, block) }
                .tap { |names| defined_methods.push(*names).uniq! }
  end

  protected

  def defined_methods
    @defined_methods ||= []
  end

  class << self
    def each(&does)
      Base.each(&does)
    end

    def call(*method_names, &does)
      each(&does).new(*method_names)
    end

    def included(base)
      return if base.respond_to? :[]

      class << base
        alias_method :[], :new
      end
    end
  end
end
