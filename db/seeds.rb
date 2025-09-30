MovieGenre.destroy_all
Movie.destroy_all
Genre.destroy_all

genres = [
  {
    name: "Action",
    description: "High-energy films featuring physical feats, chase scenes, fights, and spectacular stunts."
  },
  {
    name: "Adventure", 
    description: "Stories involving exciting journeys, exploration, and quests in exotic locations."
  },
  {
    name: "Animation",
    description: "Films created using animated techniques including hand-drawn, computer-generated, or stop-motion."
  },
  {
    name: "Biography",
    description: "Films depicting the life stories of real people, often focusing on significant achievements or events."
  },
  {
    name: "Comedy",
    description: "Films designed to amuse and entertain through humor, wit, and lighthearted situations."
  },
  {
    name: "Crime",
    description: "Stories involving criminal activities, investigations, and the criminal justice system."
  },
  {
    name: "Drama",
    description: "Serious films focusing on character development and emotional themes with realistic situations."
  },
  {
    name: "Family",
    description: "Films suitable for all ages, often emphasizing family values and relationships."
  },
  {
    name: "Fantasy",
    description: "Stories featuring magical elements, mythical creatures, and supernatural phenomena."
  },
  {
    name: "Film-Noir",
    description: "Dark, stylistic films often featuring crime, moral ambiguity, and cynical characters."
  },
  {
    name: "History",
    description: "Films set in the past, depicting historical events, periods, or figures."
  },
  {
    name: "Horror",
    description: "Films designed to frighten, unsettle, and create suspense through scary situations."
  },
  {
    name: "Music",
    description: "Films where music plays a central role, including musicals and stories about musicians."
  },
  {
    name: "Musical",
    description: "Films featuring songs and dance numbers as integral parts of the storytelling."
  },
  {
    name: "Mystery",
    description: "Stories involving puzzles, unexplained events, or crimes that need to be solved."
  },
  {
    name: "Romance",
    description: "Films focusing on love stories and romantic relationships between characters."
  },
  {
    name: "Sci-Fi",
    description: "Science fiction films exploring futuristic concepts, technology, and space exploration."
  },
  {
    name: "Sport",
    description: "Films centered around sports, athletes, and competitive activities."
  },
  {
    name: "Supernatural",
    description: "Stories involving paranormal activities, ghosts, and otherworldly phenomena."
  },
  {
    name: "Thriller",
    description: "Suspenseful films designed to keep audiences on edge with tension and excitement."
  },
  {
    name: "War",
    description: "Films depicting warfare, military conflicts, and their impact on individuals and society."
  },
  {
    name: "Western",
    description: "Stories set in the American Old West, featuring cowboys, outlaws, and frontier life."
  }
]

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
