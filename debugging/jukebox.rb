require_relative './song_library.rb'

require 'pry'

def jukebox(command)
  if command.downcase == "list"
    list_library
  else
    parse_command(command.downcase)
  end
end

def list_artist(artist, album_hash)
   artist_list = "\n---------------\n"
   artist_list += "#{artist}:\n"
   artist_list += "---------------"
   album_hash[:albums].each do |album_name, songs_hash|
     artist_list += "\n#{album_name}:\n\t"
     artist_list += songs_hash[:songs].join("\n\t")
   end
   artist_list
end

def list_library
  lib = full_library
  lib.each do |artist, album_hash|
    puts list_artist(artist, album_hash)
  end
end

def parse_artist(command, lib)
  cmd = command
  parsed = false
  if lib.has_key?(cmd)
    puts list_artist(cmd, lib[cmd])
    parsed = true
  else
    lib.each do |artist, hash|
      if command.downcase == artist.to_s.gsub("_"," ").downcase
        puts list_artist(artist, lib)
        parsed = true
        break
      end
    end
  end
  parsed
end

def parse_command(command)
  command_array = command.split(' ')
  i = -1
  capitalized_command_array = command_array.map do |word|
    i += 1
    if i == 0
      word.capitalize
    elsif word == "and" || word == "the"
      word
    else
      word.capitalize
    end
  end
  parse_artist(capitalized_command_array.join(' '), full_library) || play_song(capitalized_command_array.join(' '), full_library) || not_found(command)
end

def play_song(command, lib)
  lib.each do |artist, albums_hash|
    albums_hash.each do |album_name, albums_hash|
      albums_hash.each do |album, songs_hash|
        songs_hash.each do |songs_array, songs|
          songs.each do |song|
            if song.downcase == command.downcase
              puts "Now Playing: #{artist}: #{album} - #{song}\n\n"
              return true
            end
          end
        end
      end
    end
  end
  false
end

def not_found(command)
  puts "I did not understand '#{command}'!\n\n"
  true
end