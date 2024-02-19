require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def check_word(word, grid)
    word.chars.all? do |letter|
      grid.delete('').downcase.count(letter) >= word.downcase.count(letter)
    end
  end

  def trash(var)
    var ? @score = "Sorry but #{params[:word]} is not an english word" : @score = "Sorry but #{params["word"]} can not be build with the letters #{params["letters"]}"
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if user["found"] == true && check_word(params["word"], params["letters"]) == true
      @score = 'yay'
    else
      trash(check_word(params["word"], params["letters"]))
    end
  end
end
