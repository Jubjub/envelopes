extends Sprite


var envelope_number = 0
var font_number = 0
var font_sizes = [35, 54, 32, 40, 25, 35, 35, 25]
var torn_texture = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.envelope_number = (randi() % 4) + 1
	self.texture = load('res://envelope_%s.png' % self.envelope_number)
	self.torn_texture = load('res://envelope_%s_torn.png' % envelope_number)
	var center = Vector2(0, 0)
	var stamp_count = (randi() % 3) + 1
	var last_stamp = null
	for i in range(1, stamp_count + 1):
		var new_stamp = random_stamp("StampPosition%s" % i)
		add_child(new_stamp)
		last_stamp = new_stamp
		center += get_node("StampPosition%s" % i).position
	center /= stamp_count
	var cancellation = Sprite.new()
	cancellation.texture = load('res://cancellation%s.png' % ((randi() % 9) + 1))
	cancellation.position = center
	cancellation.scale = Vector2(2, 2)
	cancellation.rotation = deg2rad(rand_range(-5, 5))
	cancellation.modulate.a = .7
	if stamp_count == 1:
		cancellation.position.x -= last_stamp.texture.get_size().x / 2
		cancellation.position.y -= 50
	add_child(cancellation)
	self.font_number = (randi() % 8) + 1
	var new_font = DynamicFont.new()
	new_font.font_data = load('res://handwritten%s.ttf' % self.font_number)
	var address = get_node("../Address")
	new_font.set_size(self.font_sizes[self.font_number - 1])
	new_font.use_filter = true
	new_font.use_mipmaps = true
	address.add_font_override("font", new_font)
	# address load
	address.text = global.people[randi() % global.people.size()]
	
func random_stamp(position_name):
	var stamp = Sprite.new()
	stamp.texture = load('res://stamp%s.png' % ((randi() % 18) + 1))
	stamp.scale = Vector2(1.8, 1.8)
	stamp.position = get_node(position_name).position + Vector2(rand_range(-30, 30), rand_range(-30, 30))
	stamp.rotation = deg2rad(rand_range(-5, 5))
	return stamp

func open():
	$RippingSound.play()
	texture = torn_texture
	$'../AnimationPlayer'.play("TakeOutLetter")
