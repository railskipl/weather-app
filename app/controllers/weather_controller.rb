class WeatherController < ApplicationController
	include Weather

	def show

		all_temperature = [get_city_1["temp"],get_city_2["temp"],get_city_3["temp"],get_city_4["temp"],get_city_5["temp"]].sort!
		max_temp = all_temperature.last
		min_temp = all_temperature.first
		@avg_temp = (max_temp + min_temp)/2
		r1 = (@avg_temp-5)
		r2 = (@avg_temp+5)

		data1 = []

		data1 << {"city" => get_city_1["city"], "temp" => get_city_1["temp"]} if (get_weather_1 == "Clear") && get_city_1["temp"].between?(r1,r2)
		data1 << {"city" => get_city_2["city"], "temp" => get_city_2["temp"]} if (get_weather_2 == "Clear") && get_city_2["temp"].between?(r1,r2)
		data1 << {"city" => get_city_3["city"], "temp" => get_city_3["temp"]} if (get_weather_3 == "Clear") && get_city_3["temp"].between?(r1,r2)
		data1 << {"city" => get_city_4["city"], "temp" => get_city_4["temp"]} if (get_weather_4 == "Clear") && get_city_4["temp"].between?(r1,r2)
		data1 << {"city" => get_city_5["city"], "temp" => get_city_5["temp"]} if (get_weather_5 == "Clear") && get_city_5["temp"].between?(r1,r2)		

		data2 = []

		data2 << {"city" => get_city_1["city"], "temp" => get_city_1["temp"]} if (get_weather_1 == "Clouds") && get_city_1["temp"].between?(r1,r2)
		data2 << {"city" => get_city_2["city"], "temp" => get_city_2["temp"]} if (get_weather_2 == "Clouds") && get_city_2["temp"].between?(r1,r2)
		data2 << {"city" => get_city_3["city"], "temp" => get_city_3["temp"]} if (get_weather_3 == "Clouds") && get_city_3["temp"].between?(r1,r2)
		data2 << {"city" => get_city_4["city"], "temp" => get_city_4["temp"]} if (get_weather_4 == "Clouds") && get_city_4["temp"].between?(r1,r2)
		data2 << {"city" => get_city_5["city"], "temp" => get_city_5["temp"]} if (get_weather_5 == "Clouds") && get_city_5["temp"].between?(r1,r2)		

		@recommended_city = ''

		if data1.empty?
			arr1 = []
			final_weather = data2.max_by { |x| x["temp"].to_f}
			@recommended_city = final_weather["city"]
		else
			arr2 = []
			final_weather2 = data1.max_by { |x| x["temp"].to_f}
			@recommended_city = final_weather2["city"]	
		end	
		@weather_all_cities = [get_city_1, get_city_2, get_city_3, get_city_4, get_city_5]

		render :show	
	end

	def get_weather_1 
		get_city_1["main"]
	end	

	def get_weather_2
		get_city_2["main"]
	end

	def get_weather_3
		get_city_3["main"]
	end			

	def get_weather_4
		get_city_4["main"]
	end		

	def get_weather_5
		get_city_5["main"]
	end	

	def get_city_1
		city_1 = "Berlin"
		county_code_1 = "DE"
		weather_1 = open_weather_api.current city: city_1, country_code: county_code_1
		parse_weather(weather_1)
	end	

	def get_city_2
		city_2 = "Munich"
		county_code_2 = "DE"
		weather_2 = open_weather_api.current city: city_2, country_code: county_code_2
		parse_weather(weather_2)
	end	

	def get_city_3
		city_3 = "stuttgart"
		county_code_3 = "DE"
		weather_3 = open_weather_api.current city: city_3, country_code: county_code_3
		parse_weather(weather_3)
	end	

	def get_city_4
		city_4 = "Hamburg"
		county_code_4 = "DE"
		weather_4 = open_weather_api.current city: city_4, country_code: county_code_4
		parse_weather(weather_4)
	end			

	def get_city_5
		city_5 = "Dresden"
		county_code_5 = "DE"
		weather_5 = open_weather_api.current city: city_5, country_code: county_code_5
		parse_weather(weather_5)
	end				

private

  def open_weather_api
    OpenWeatherAPI::API.new api_key: "cb463bd718df17064b5196f9eb07ebb0"
  end
end
