module Weather
extend ActiveSupport::Concern

	def parse_weather(weather_json)
		main = weather_json["weather"].first["main"]
		description = weather_json["weather"].first["description"]
		temp = to_celcius(weather_json["main"]["temp"]).ceil
		humidity = weather_json["main"]["humidity"]
		pressure = weather_json["main"]["pressure"]
		city = weather_json["name"]
		data = {"city" => city, "main" => main, "description" => description, "temp" => temp, "humidity" => humidity, "pressure" => pressure}
	end

	def to_celcius(temp)
		temp - 273.15
	end	

	def compare_weather(weather)
		if weather = "clear"
			p "Good Weather"	
		else
			p "Bad Weather"	
		end	
	end
end