require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # check all letter are included continue
    if all_letters_are_included_in_array?
      if english_word?
        @score = "Correct english word"
      else
        @score = "Not an english word"
      end
    else
      @score = "Answer not included in letters grid"
    end
  end

  private

  def all_letters_are_included_in_array?
    answer = params[:answer].upcase
    letters = params[:letters]
    answer_array = answer.split('')
    letter_array = letters.split('')

    answer_array.each do |letter|
      return false unless letter_array.include?(letter)
    end
    true
  end

  def english_word?
    answer = params[:answer]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end
end
