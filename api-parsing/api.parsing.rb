require 'json'
require 'rest_client'
require 'pry'
require 'awesome_print'

reddit_hash = JSON.parse(RestClient.get('http://reddit.com/.json'))

reddit_html = "                  "

def make_post_html(post_hash)
  data_hash = post_hash["data"]
  post_string2 = "<li>
                      <a href=\"http://reddit.com#{data_hash["permalink"]}\">
                        <h1>#{data_hash["title"]}</h1>
                        <img src=\"#{data_hash["thumbnail"]}\" />
                        <h4>Upvotes:</p>
                        <p>#{data_hash["ups"]}</h4>
                        <p>Downvotes:</p>
                        <h4>#{data_hash["downs"]}</h4>
                      </a>
                  </li>
                  "
end

reddit_hash["data"]["children"].each do |post|
  unless post["data"]["over_18"] == true
    reddit_html << make_post_html(post)
  end
end

reddit_html_file = File.new("reddit.html", "w+")
  if reddit_html_file
   reddit_html_file.syswrite(reddit_html)
  else
   puts "Unable to open file!"
  end
reddit_html_file.close