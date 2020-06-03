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

  describe "call" do
    subject { DefineMethods.call('foo', :bar) { __method__ } }

    it "returns new module with defined methods" do
      _(subject).must_be_kind_of Module
      _(subject).wont_be_kind_of Class
      _(subject.instance_methods).must_include :foo, :bar
    end
  end

  describe "each" do
    subject { DefineMethods.each { __method__ } }

    it "returns sub class of base class" do
      _(subject).must_be_kind_of Class
      _(subject).wont_equal DefineMethods::Base
      _(subject.ancestors).must_include DefineMethods::Base
    end
  end
end
