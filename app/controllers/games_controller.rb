require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letter_grid = []
    10.times { letter_grid << ('A'..'Z').to_a[rand(26)] }
    @letters = letter_grid
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    json_response = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    if JSON.parse(json_response)["found"]
      if @word.upcase.chars.all? { |letter| @letters.include?(letter) && @letters.delete_at(@letters.index(letter)) }
        @valid = "win"
        session[:score] ? session[:score] += @word.length : session[:score] = @word.length
      else
        @valid = "almost"
      end
    else
      @valid = "idiot"
    end
  end
end
