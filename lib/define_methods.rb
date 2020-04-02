require "define_methods/version"

module DefineMethods
  def define_methods(*method_names, &block)
    method_names.map { |name| define_method(name, block) }
                .tap { |names| defined_methods.push(*names).uniq! }
  end

  protected

  def defined_methods
    @defined_methods ||= []
  end
end
