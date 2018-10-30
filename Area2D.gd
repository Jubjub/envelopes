extends Area2D

var dragging = false
var overlappingLetter = null
var startingPosition = null

func _ready():
	startingPosition = $"../".position

func _input(event):
	if event is InputEventMouseMotion:
		if dragging:
			get_parent().position += event.relative

func release():
	var areas = get_overlapping_areas()
	var found_letter = null
	if areas:
		for area in areas:
			print(area.name)
			if not area.name == 'LetterArea':
				pass
			else:
				found_letter = area.get_parent()
				print("released on letter")
				found_letter.open()
				break
	if not found_letter:
		print(startingPosition)
		print($'..'.position)
	$Tween.interpolate_property($'..', "position", $"..".position, startingPosition, .5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not $Tween.is_active():
		if dragging:
			dragging = false
			release()
		else:
			dragging = true

func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN if dragging else Input.MOUSE_MODE_VISIBLE)
	if dragging:
		z_index = 2
	else:
		z_index = 0

func _on_Area2D_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_MOVE)

func _on_Area2D_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
