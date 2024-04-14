require 'httparty'
require 'json'

def fetch_user_repos(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)
  JSON.parse(response.body)
end

def find_most_starred_repo(repos)
  most_starred_repo = repos.max_by { |repo| repo['stargazers_count'].to_i }
  {
    name: most_starred_repo['name'],
    description: most_starred_repo['description'],
    stars: most_starred_repo['stargazers_count'],
    url: most_starred_repo['html_url']
  }
end

def display_repo_info(repo)
  puts "Name: #{repo[:name]}"
  puts "Description: #{repo[:description]}"
  puts "Stars: #{repo[:stars]}"
  puts "URL: #{repo[:url]}"
end



username = ARGV[0]
repos = fetch_user_repos(username)
most_starred_repo = find_most_starred_repo(repos)
display_repo_info(most_starred_repo)
