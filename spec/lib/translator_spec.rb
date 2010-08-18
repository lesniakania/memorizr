require 'spec_helper'

describe Translator do
  it "should retrieve meanings properly" do
    response = 
      '<div id="dict">
        <p id="dict_head">Slownik</p>
        <table><tr>
          <td><b>rzeczownik</b>
            <ol><li>miska</li><li>misa<</ol></td>
          <td><b>czasownik</b>
            <ol><li>zaserwowac</li></ol></td>
        </tr></table>
      </div>'
    Net::HTTP.stubs(:get_response).returns(response)
    response.stubs(:body).returns(response)
    meanings = Translator.extract_meanings('miska', 'en', 'pl')
    Set.new(meanings).should == Set.new(['miska', 'misa', 'zaserwowac'])
  end
end
