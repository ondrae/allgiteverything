require 'uri'

class GithubProject
  include ActiveModel::Validations
  validates_format_of :url, :with => URI.regexp
  validates_format_of :url, :with => /github\.com\/[a-zA-Z\-_0-9]+\/[a-zA-Z\-_0-9]+\/?/

  attr_accessor :url

  def initialize(url)
    @url = url
    @github_api = Octokit::Client.new(:access_token => ENV["github_token"])
    /github\.com\/(?<repo_path>[a-zA-Z\-_0-9]+\/[a-zA-Z\-_0-9]+)\/?/ =~ @url
    @repo_path = repo_path
  end

  def data
    @data ||= @github_api.repo @repo_path
  end

  def repo_path
    @repo_path
  end

  def name
    self.data[:name]
  end

  def description
    self.data[:description]
  end

end