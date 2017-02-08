require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================



    @street_address.gsub(' ', '+')

    @url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address

    @parsed_data = JSON.parse(open(@url).read)

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]


    @weatherurl = "https://api.darksky.net/forecast/31deec606cce366b4ea270c201dce80b/"+@latitude.to_s+","+@longitude.to_s

    @parsed_weather = JSON.parse(open(@weatherurl).read)

    @current_temperature = @parsed_weather["currently"]["temperature"]

    @current_summary = @parsed_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_weather["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_weather["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_weather["daily"]["summary"]


    render("meteorologist/street_to_weather.html.erb")
  end
end
