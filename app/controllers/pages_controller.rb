require 'open-uri'
require 'json'

class PagesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
  @score = params[:score]
  # score_and_message = score_and_message(@score, @letters, result[:time])
  @result = @score.split("")
  if included?(@score, @letters)

      if english_word?(@score)
        @message = "well done"
      else
        @message = "0, not an english word"
      end
  else
     @message = "0, not in the grid"
  end
  end


# def included?(guess, grid)
#   @score.split("").chars.all? { |letter| @score.count(letter) <= @letters.count(letter) }
# end


def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end


end
