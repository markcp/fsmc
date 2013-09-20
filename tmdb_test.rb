require 'rubygems'
require 'httparty'
require 'cgi'

class Movie
  include HTTParty
  debug_output $stderr
  base_uri 'http://api.themoviedb.org'

  def self.search(search_string)
    get('/3/search/movie?query=' + CGI.escape(search_string) + '&api_key=06b90d8aa0aaf30a186b507edf49bf6d&append_to_response=casts',
       headers: { 'accept' => 'application/json' })
  end
end

puts Movie.search("The Unspeakable Act")


