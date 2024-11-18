require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    url = "https://dictionary.lewagon.com/#{params[:result]}"
    serialized_url = URI.parse(url).read
    word = JSON.parse(serialized_url)
    exist = word["found"]
    if exist && params[:result].upcase.chars.all? { |letter| params[:result].upcase.count(letter) <= params[:letters].upcase.count(letter) }
      @word = "Congratulation! #{params[:result]} is a valid english word, and it's in the grid!"
    elsif exist == false
      @word = "Sorry but #{params[:result]} does not seem to be a valid English word..."
    else
      @word = "Sorry but #{params[:result]} can't be built out of #{params[:letters]}"
    end
  end
end
