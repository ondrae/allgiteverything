class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    get_help_wanted_issues(orgs: Organization.all, repos: Project.all)
  end

  def get_help_wanted_issues(orgs:, repos:)
    return if orgs.blank? and repos.blank?

    orgs_for_search = orgs.map { |org| "org:" + org.name }.uniq
    repos_for_search = repos.map { |repo| "repo:" + repo.full_name }.uniq
    query = "type:issue state:open label:\"help wanted\"" + orgs_for_search.join(" ") + " " + repos_for_search.join(" ")
    @github_api = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"], auto_paginate: false)
    result = @github_api.search_issues(query, { sort: "updated", per_page: 10 })
    @issues = result.items.map { |github_issue| Issue.new github_issue }
  end

  def rate_limit
    github_api = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
    render inline: github_api.rate_limit.to_json
  end

  private

  def must_be_logged_in
    redirect_to user_github_omniauth_authorize_path unless current_user
  end
end
