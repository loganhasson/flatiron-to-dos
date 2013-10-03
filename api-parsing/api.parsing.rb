require 'json'
require 'rest_client'
require 'pry'
require 'awesome_print'
require 'colorize'

# reddit_html = "                  "

if ARGV.first
  reddit_hash = JSON.parse(RestClient.get('http://reddit.com/r/' + ARGV.first + '.json'))
else
  reddit_hash = JSON.parse(RestClient.get('http://reddit.com/.json'))
end

class Post

  POSTS = []

  attr_accessor :permalink, :title, :id

  def initialize(permalink, title, id)
    self.permalink = "http://reddit.com/" + permalink
    self.title = title
    self.id = id

    POSTS << self
  end

  def self.launch_story(path)
    binding.pry
    post_to_open = POSTS.select { |post| post.@id == path }[0]
    `open #{post_to_open.permalink}`
  end

end

def make_posts(post_hash)
  data_hash = post_hash["data"]
  Post.new(data_hash["permalink"], data_hash["title"], data_hash["id"])
end

# def make_post_html(post_hash)
#   data_hash = post_hash["data"]
#   post_string2 = "<li>
#                       <a href=\"#{data_hash["url"]}\">
#                         <h1>#{data_hash["title"]}</h1>
#                         <img src=\"#{data_hash["thumbnail"]}\" />
#                         <p>Upvotes:</p>
#                         <h4>#{data_hash["ups"]}</h4>
#                         <p>Downvotes:</p>
#                         <h4>#{data_hash["downs"]}</h4>
#                       </a>
#                       <h4>Content:</h4>
#                       <p>#{data_hash["selftext"]}</p>
#                   </li>
#                   "
# end

reddit_hash["data"]["children"].each do |post|
  unless post["data"]["over_18"] == true
    make_posts(post)
  end
end

path = ''
while path
  system("clear")
  Post::POSTS.each do |post|
    puts post.id.red + ' ' + post.title.black
  end
  $stdout.flush
  path = $stdin.gets.chomp

  if path == 'exit'
    break
  else
    Post.launch_story(path)
  end

end

# reddit_html_file = File.new("reddit.html", "w+")
#   if reddit_html_file
#    reddit_html_file.syswrite(reddit_html)
#   else
#    puts "Unable to open file!"
#   end
# reddit_html_file.close