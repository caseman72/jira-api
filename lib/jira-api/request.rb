module Jira
  class Request
    # Returns response body of specified link
    def self.fetch(link, auth, ua)
      url = URI.parse(link)
      resp = Net::HTTP.start(url.host, url.port) do |http|
        http.get(url.path + (url.query ? "?" + url.query.to_s : ""), {'Authorization' => "Basic #{auth}", 'X-Atlassian-Token' => 'no-check', 'User-Agent' => ua})
      end
      return resp.body if resp.kind_of?(Net::HTTPOK)
    end

    def self.post(link, params, auth, ua)
      url = URI.parse(link)
      params = url_encode(params)
      resp = Net::HTTP.start(url.host, url.port) do |http|
        http.post(url.path + (url.query ? "?" + url.query.to_s : ""), params, {'Authorization' => "Basic #{auth}", 'X-Atlassian-Token' => 'no-check', 'User-Agent' => ua})
      end
      return resp['location'] if resp.kind_of?(Net::HTTPFound)
    end

    def self.url_encode(params)
      uri_pattern = Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
      params.to_a.each.inject([]) { |a, p| a << p.first.to_s + "=" + URI.escape(p.last.to_s, uri_pattern) }.join("&")
    end
  end
end
