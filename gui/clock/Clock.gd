extends Panel


# Time of day icons
const DAY_ICON = Rect2(16, 0, 16, 16)
const NIGHT_ICON = Rect2(0, 0, 16, 16)


# Clock info
var clock_season
var clock_day
var clock_time

var time_cycle


# Called when the node enters the scene tree for the first time.
func _ready():
	time_cycle = get_tree().get_root().get_node("Game/TimeCycle")
	
	clock_season = time_cycle.get_season()
	clock_day = time_cycle.day
	
	# Connects the clock GUI to the game's day-night cycle
	var error
	
	error = time_cycle.connect("day_changed", self, "_on_day_changed")
	error = time_cycle.connect("season_changed", self, "_on_season_changed")
	error = time_cycle.connect("time_changed", self, "_on_time_changed")
	
	if error:
		print("Connect failed...")
		
	$Date.text = str(clock_season) + ' ' + str(clock_day)


func _on_day_changed(day):
	clock_day = day
	
	$Date.text = str(clock_season) + " " + str(clock_day)


func _on_season_changed(season):
	clock_season = season
	
	$Date.text = str(clock_season) + " 1"


func _on_time_changed(time):
	clock_time = time
	
	$Time.text = "%02d:%02d" % [time['hour'], time['minute']]
	
	if clock_time['hour'] == time_cycle.dawn_hour:
		$TimeIcon.texture.region = DAY_ICON
	elif clock_time['hour'] == time_cycle.dusk_hour:
		$TimeIcon.texture.region = NIGHT_ICON
