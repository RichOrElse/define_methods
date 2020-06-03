require_relative "../test_helper"

describe DefineMethods::Base do
  let(:base_class) { DefineMethods::Base }
  let(:sub_class) { base_class.each(&returns_baz) }
  let(:sub_module) { sub_class[:foo, :bar] }
  let(:returns_baz) { -> { :baz } }

  describe "each" do
    it "returns new sub class" do
      _(sub_class).must_be_kind_of Class
      _(sub_class).wont_equal base_class
      _(sub_class).wont_equal base_class.each(&returns_baz)
    end
  end

  describe "[]" do
    it "returns new sub module" do
      _(sub_module).must_be_kind_of Module
      _(sub_module).wont_be_kind_of Class
      _(sub_module).wont_equal sub_class[:foo, :bar]
    end
  end

  describe "#instance_methods" do
    it "includes defined methods" do
      _(sub_module.instance_methods).must_include :foo, :bar
    end
  end

  describe '#inspect' do
    it "returns namespace with defined methods" do
      _(sub_module.inspect).must_equal 'DefineMethods[foo bar]'
    end

    describe 'when sub class named' do
      before { def sub_class.name; 'SubClass' end }

      it "names sub class with defined methods" do
        _(sub_module.inspect).must_equal 'SubClass[foo bar]'
      end
    end

    describe 'when sub module named' do
      before { def sub_module.name; 'SubModule' end }

      it "names sub module with defined methods" do
        _(sub_module.inspect).must_equal 'SubModule[foo bar]'
      end
    end
  end
end
