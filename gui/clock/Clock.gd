extends Panel


# Time of day icons
const DAY_ICON = Rect2(96, 80, 16, 16)
const NIGHT_ICON = Rect2(80, 80, 16, 16)


# Clock info
var clock_season
var clock_day
var clock_time


# Called when the node enters the scene tree for the first time.
func _ready():
	clock_season = get_tree().get_root().get_node("Game/TimeCycle").get_season()
	clock_day = get_tree().get_root().get_node("Game/TimeCycle").day
	
	# Connects the clock GUI to the game's day-night cycle
	var error
	
	error = get_tree().get_root().get_node("Game/TimeCycle").connect("day_changed", self, "_on_day_changed")
	error = get_tree().get_root().get_node("Game/TimeCycle").connect("season_changed", self, "_on_season_changed")
	error = get_tree().get_root().get_node("Game/TimeCycle").connect("time_changed", self, "_on_time_changed")
	
	if error:
		print("Connect failed...")


func _on_day_changed(day):
	clock_day = day
	
	$Date.text = str(clock_season) + " " + str(clock_day)


func _on_season_changed(season):
	clock_season = season
	
	$Date.text = str(clock_season) + " 1"


func _on_time_changed(time):
	clock_time = time
	
	$Time.text = "%02d:%02d" % [time['hour'], time['minute']]
	
	if clock_time['hour'] == get_tree().get_root().get_node("Game/TimeCycle").dawn_hour:
		$TimeIcon.texture.region = DAY_ICON
	elif clock_time['hour'] == get_tree().get_root().get_node("Game/TimeCycle").dusk_hour:
		$TimeIcon.texture.region = NIGHT_ICON
