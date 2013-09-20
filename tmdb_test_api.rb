require 'rubygems'
require 'tmdb-api'

TMDb.api_key = '06b90d8aa0aaf30a186b507edf49bf6d'

movie = TMDb::Movie.find(24, append_to_response: 'cast')

puts movie.cast
