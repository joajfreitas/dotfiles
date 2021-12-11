-- User variables and preferences
local user = {
	-- >> Default applications <<
	-- Check apps.lua for more
	terminal = "alacritty",
	floating_terminal = "alacritty",
	browser = "firefox",
	file_manager = "uxterm -1 --class files -e ranger",
	editor = "alacritty -e vim",
	email_client = "uxterm -1 --class email -e neomutt",
	music_client = "uxterm -o font_size=12 --class music -e ncmpcpp",

	-- >> Web Search <<
	web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
	-- web_search_cmd = "xdg-open https://www.google.com/search?q=",

	-- >> User profile <<
	profile_picture = os.getenv("HOME").."/.config/awesome/profile.jpeg",

	-- Directories with fallback values
	dirs = {
		downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
		documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
		music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
		pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
		videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
		-- Make sure the directory exists so that your screenshots
		-- are not lost
		screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
	},

	-- >> Sidebar <<
	sidebar = {
		hide_on_mouse_leave = true,
		show_on_mouse_screen_edge = true,
	},

	-- >> Battery <<
	-- You will receive notifications when your battery reaches these
	-- levels.
	battery_threshold_low = 20,
	battery_threshold_critical = 5,

	-- >> Weather <<
	-- Get your key and find your city id at
	-- https://openweathermap.org/
	-- (You will need to make an account!)
	openweathermap_key = "0d5089533d9410bdb177fd5e26bfd581",
	openweathermap_city_id = "2267057",
	-- > Use "metric" for Celcius, "imperial" for Fahrenheit
	weather_units = "metric",

	lock = "i3lock",
}

return user
