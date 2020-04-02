require "test_helper"

describe DefineMethods do
  describe "#define_methods" do
    subject { Class.new.extend DefineMethods }

    before do
      subject.define_methods('foo', :bar) { __method__ }
      @instance = subject.new
    end

    it "defines multiple methods" do
      _(subject.instance_methods).must_include :foo, :bar
      _(@instance.foo).must_equal :foo
      _(@instance.bar).must_equal :bar
    end
  end
end
