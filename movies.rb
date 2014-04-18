require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'



get '/' do <<EOS
	<h1> Movie Search!</h1>
		<form action = "/results" method = "get" />
		<input type = "text" name="movies" />
		<input type = "submit" />
EOS
end

get '/results' do
	if params["movie"] == ""
		redirect '/'
	end

	response = Typhoeus.get("http://www.omdbapi.com/", :params => { :s => params["movie"] })
	result = JSON.parse(response.body)
	str = ""

	result["Search"].each do |movie|
		str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"""
	end
		str
end


get '/poster/:imdbID' do
response = Typhoeus.get("http://www.omdbapi.com/", :params => { :i => params["imdbID"]})
movie_poster = JSON.parse(response.body)
"<img src = #{movie_poster["Poster"]} />"

end


