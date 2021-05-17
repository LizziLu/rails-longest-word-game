require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << [*'A'...'Z'].sample
    end
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(url).read
    parsed = JSON.parse(dictionary)
    attempt = @word.upcase

    if !attempt.chars.all? { |letter| attempt.count(letter) <= params[:letters].count(letter) }
      @score = "The word is not in the grid!"
    elsif parsed["found"] == false
      @score = "Not an English word!"
    else
      @score = "Well Done!"
    end

  end
end

