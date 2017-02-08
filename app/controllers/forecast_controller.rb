require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    @weatherurl = "https://api.darksky.net/forecast/31deec606cce366b4ea270c201dce80b/"+@lat+","+@lng

    @parsed_weather = JSON.parse(open(@weatherurl).read)


    @current_temperature = @parsed_weather["currently"]["temperature"]

    @current_summary = @parsed_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_weather["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_weather["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_weather["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
