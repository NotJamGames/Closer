extends CenterContainer


var time_intervals : Array[float]
var progress_intervals : Array[float]


@export var progress_bar : ProgressBar


signal load_completed()


# NOTE: load duration will always be .1 seconds longer than specified
# to allow the user time to see the empty bar on scene load
func configure_load(load_duration : float) -> void:
	# we should never need to do this, but just in case...
	progress_intervals.clear()
	time_intervals.clear()

	progress_bar.value = .0

	# populate progress and time intervals with random values
	# with time intervals totalling load duration
	# and progress intervals totalling 1 (max progress bar value)
	var current_load_duration : float = load_duration
	var min_interval : float = load_duration * .01
	while current_load_duration > min_interval:
		var new_interval = randf_range\
				(min_interval, min(current_load_duration, load_duration * .25))
		time_intervals.append(new_interval)
		progress_intervals.append(new_interval / load_duration)
		current_load_duration -= new_interval

	time_intervals.append(current_load_duration)
	progress_intervals.append(current_load_duration / load_duration)

	var timer : SceneTreeTimer = get_tree().create_timer(.1)
	timer.timeout.connect(update_load_state, CONNECT_ONE_SHOT)


func update_load_state() -> void:
	# realistically, these should always be the same size
	# but no harm in checking both
	if time_intervals.size() == 0 or progress_intervals.size() == 0:
		@warning_ignore("confusable_local_declaration")
		var timer : SceneTreeTimer = get_tree().create_timer(.2)
		timer.timeout.connect(complete_load, CONNECT_ONE_SHOT)
		return

	progress_bar.value += progress_intervals.pop_back()

	var timer : SceneTreeTimer = get_tree().create_timer\
			(time_intervals.pop_back())
	timer.timeout.connect(update_load_state, CONNECT_ONE_SHOT)


func complete_load() -> void:
	progress_bar.value = .0
	load_completed.emit()
