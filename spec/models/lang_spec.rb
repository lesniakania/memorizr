require 'spec_helper'

describe Lang do
  describe "validations" do
    before(:each) do
      @lang = Lang.first(:value => 'en')
    end

    it "should be valid" do
      @lang.should be_valid
    end

    it "should not be valid without value" do
      @lang.value = nil
      @lang.should_not be_valid
    end

    it "should be unique" do
      @lang.save
      lang = Factory.build(:lang, :value => @lang.value)
      lang.should_not be_valid
    end
  end

  describe "defaults" do
    it "default 'from language' should be English" do
      Lang.default_from.should == 'en'
    end

    it "default 'to language' should be English" do
      Lang.default_to.should == 'pl'
    end
  end
end