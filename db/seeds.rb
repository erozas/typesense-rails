MovieGenre.destroy_all
Movie.destroy_all
Genre.destroy_all

genres_file = Rails.root.join('app', 'data', 'genres.json')
genres = JSON.parse(File.read(genres_file))

puts "Creating genres..."
genre_objects = {}
genres.each do |genre_data|
  genre = Genre.create!(genre_data)
  genre_objects[genre.name] = genre
  puts "Created genre: #{genre.name}"
end

movies_file = Rails.root.join('app', 'data', 'movies.json')
movies_data = JSON.parse(File.read(movies_file))

puts "Creating movies..."
movies_data.each do |movie_data|
  movie = Movie.create!(
    title: movie_data['title'],
    year: movie_data['year'],
    director: movie_data['director'],
    rating: movie_data['rating'],
    runtime: movie_data['runtime'],
    description: movie_data['description']
  )
  
  movie_data['genre'].each do |genre_name|
    genre = genre_objects[genre_name]
    if genre
      MovieGenre.create!(movie: movie, genre: genre)
    else
      puts "Warning: Genre '#{genre_name}' not found for movie '#{movie.title}'"
    end
  end
  
  puts "Created movie: #{movie.title} (#{movie.year})"
end

puts "Seed completed!"
puts "Created #{Genre.count} genres"
puts "Created #{Movie.count} movies"
puts "Created #{MovieGenre.count} movie-genre associations"
