require 'net/http'
require 'uri'
require 'nokogiri'

class Translator
  BASE_URL = "https://www.googleapis.com/language/translate/v2"
  API_KEY = "AIzaSyAkQ54KDmJI8xsU8OP4C60EiJTgieXSSto"

  def self.extract_meanings(word, from, to)
    url = build_url(word.value, from.value, to.value)
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

  def self.extract_meanings_from_api
    uri = build_url(word.value, from.value, to.value)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)
    results = [data['data']['translations'].first['translatedText']]
  end

  def self.build_api_uri(word, from, to)
    URI.parse("#{BASE_URL}?key=#{API_KEY}&source=#{from}&target=#{to}&q=#{URI.encode(word)}")
  end
end
