Gem::Specification.new do |s|
  s.name = "jira-api"
  s.version = "0.1.1"
  s.date = "2012-04-24"
  s.description = "Simple API access to Jira"
  s.summary = "Jira API"
  s.authors = ["Casey Manion"]
  s.email = "casey@manion.com"
  s.homepage = "http://github.com/caseman72/jira-api"

  s.files = %w[
    .gitignore
    README.rdoc
    lib/jira-api.rb
    lib/jira-api/jira.rb
    lib/jira-api/request.rb
  ]

  s.has_rdoc = true
  s.rubygems_version = '1.3.7'
end