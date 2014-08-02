require 'nokogiri'
require 'open-uri'

module StatLoader
  class LoadPage

    def self.run(attrs)
      user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4)
        AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1"
      html = "http://ENV[HOST]/teams/#{attrs[:team].br_id}/#{attrs[:season].year}.html"
      
      doc = Nokogiri::HTML(open(html, "User-Agent" => user_agent), nil, "UTF-8")

      { :players => doc.css('#all_roster tbody tr'),
        :stat => doc.css('#totals tbody tr'),
        :adv => doc.css('#advanced tbody tr'),
        :salaries => doc.css('#salaries tbody tr')
      }
    end
  end
end
