require 'net/http'
require 'uri'
require 'nokogiri'

class Translator
  def self.extract_meanings(word, from, to)
    url = build_url(word, from, to)
    response = Net::HTTP.get_response(url)
    doc = Nokogiri::HTML(response.body)
    results = doc.xpath("//div[@id='dict']/table/tr/td/ol/li").map(&:text)
    if results.empty?
      results = doc.xpath("//span[@id='result_box']/span").map(&:text)
    end
    if results.empty?
      results = doc.xpath("//span[@id='result_box']").map(&:text)
    end
    results
  rescue
    false
  end

  def self.build_url(word, from, to)
    URI.parse("http://translate.google.pl/?hl=en&sl=#{from}&tl=#{to}&q=#{URI.encode(word)}")
  end
end
