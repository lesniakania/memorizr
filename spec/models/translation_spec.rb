require 'spec_helper'

describe Translation do
  it "should be unique" do
    word1 = Factory.build(:word)
    word2 = Factory.build(:word)
    @translation = Factory.create(:translation, :from => word1, :to => word2)
    translation = Factory.build(:translation, :from => word1, :to => word2)
    translation.should_not be_valid
  end
end