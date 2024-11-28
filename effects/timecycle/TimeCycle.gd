extends CanvasModulate


signal day_changed(day)
signal season_changed(season)
signal time_changed(time)


# Declare member variables here. Examples:
export(float) var day_real_time = 18000 # Time in seconds for one full day

# Modulate colours
export(Color) var dawn_color = Color(0.86, 0.70, 0.70, 1.0)
export(Color) var day_color = Color(1.0, 1.0, 1.0, 1.0)
export(Color) var dusk_color = Color(0.59, 0.66, 0.78, 1.0)
export(Color) var night_color = Color(0.07, 0.09, 0.28, 1.0)

# Modulate times
export(int) var dawn_hour = 5
export(int) var day_hour = 7
export(int) var dusk_hour = 17
export(int) var night_hour = 19

# Time variables
var time_ticks = 0
var time = {
	"hour": 0,
	"minute": 0
}

var ticks_per_day
var transition_duration

var current_cycle

enum Cycle {
	NIGHT,
	DAWN,
	DAY,
	DUSK,
}

# Calendar variables
var day = 1

enum Season {
	SPRING,
	SUMMER,
	FALL,
	WINTER
}

var season = Season.SPRING


# Modulate transition properties
export(float) var state_transition_duration = 1 # Time in-game hours between colours


# Called when the node enters the scene tree for the first time.
func _ready():
	ticks_per_day = day_real_time / 24
	transition_duration = (ticks_per_day * state_transition_duration) / 60
	
	set_hour(6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	_handle_time()
	_handle_date()
	
	time_ticks += 1


func _handle_time():
	time['hour'] = int(time_ticks / ticks_per_day)
	time['minute'] = int(fmod(time_ticks, ticks_per_day) / ticks_per_day * 60)
	
	if time_ticks >= day_real_time:
		time_ticks = 0
		
	emit_signal("time_changed", time)
		
	if time['hour'] >= night_hour or time['hour'] < dawn_hour:
		if current_cycle != Cycle.NIGHT:
			current_cycle = Cycle.NIGHT
		
			$Tween.interpolate_property(self, "color", dusk_color, night_color, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
	elif time['hour'] >= dawn_hour and time['hour'] < day_hour:
		if current_cycle != Cycle.DAWN:
			current_cycle = Cycle.DAWN
			
			$Tween.interpolate_property(self, "color", night_color, dawn_color, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
	elif time['hour'] >= day_hour and time['hour'] < dusk_hour:
		if current_cycle != Cycle.DAY:
			current_cycle = Cycle.DAY
			
			$Tween.interpolate_property(self, "color", dawn_color, day_color, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()
	elif time['hour'] >= dusk_hour and time['hour'] < night_hour:
		if current_cycle != Cycle.DUSK:
			current_cycle = Cycle.DUSK
			
			$Tween.interpolate_property(self, "color", day_color, dusk_color, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
			$Tween.start()


func _handle_date():
	# Change the season
	if day == 31:
		day = 0
		
		if season == Season.WINTER:
			season = Season.SPRING
		else:
			season += 1
			
		emit_signal("season_changed", get_season())
		
	# Change the day
	if time_ticks == 0:
		day += 1
		
		emit_signal("day_changed", day)


func get_season():
	if season == Season.SPRING:
		return "Spring"
	elif season == Season.SUMMER:
		return "Summer"
	elif season == Season.FALL:
		return "Fall"
	elif season == Season.WINTER:
		return "Winter"
	else:
		return ""


func set_hour(hours):
	time_ticks = (hours * ticks_per_day)
	_handle_time()
