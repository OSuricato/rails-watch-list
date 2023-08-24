# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'open-uri'
# Clear existing movies data (optional)
Movie.destroy_all

# API URL
url = 'https://tmdb.lewagon.com/movie/top_rated'

# Make the API request using open-uri
response = URI.open(url).read

# Parse the JSON response
data = JSON.parse(response)

# Seed movies
data['results'].each do |movie_data|
  Movie.create!(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )
end

puts 'seed succesfull'
