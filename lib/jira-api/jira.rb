module Jira
  JIRA_URL = ENV['JIRA_URL'].to_s.gsub!(/\/*$/, '')
  JIRA_USER_NAME = ENV['JIRA_USER_NAME']
  JIRA_AUTH_MD5 = ENV['JIRA_AUTH_MD5']
  JIRA_PROJECT_ID = ENV['JIRA_PROJECT_ID']
  JIRA_USER_AGENT = ENV['JIRA_USER_AGENT'] || 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)'

  def self.get(id)
    html = Request.fetch(JIRA_URL + '/browse/' + id.to_s, JIRA_AUTH_MD5, JIRA_USER_AGENT).to_s
    jira_id = html [/<a id=\"key-val\"[^>]*>([^<]+)<\/a>/, 1]

    # TODO ... pretty this up for display
    return JIRA_URL + '/browse/' + jira_id
  end

  def self.create(title, description)
    params = {
      'summary'    => title,
      'reporter'   => JIRA_USER_NAME,
      'description'=> '{code}' + description.to_s.gsub!(/\r?\n/, "\r\n") + '{code}',
      'assignee'   => JIRA_USER_NAME,
      'priority'   => 3,    # major
      'pid'        => JIRA_PROJECT_ID,
      'issuetype'  => 3     # task
    };

    return Request.post(JIRA_URL + '/secure/CreateIssueDetails.jspa', params, JIRA_AUTH_MD5, JIRA_USER_AGENT).to_s
  end
end
