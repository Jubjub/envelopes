extends Node2D

var paper_number = 0

func _ready():
	z_index = -1
	randomize()
	paper_number = (randi() % 5) + 1
	$PaperSprite.texture = load('res://paper%s.png' % paper_number)
	$RichTextLabel.bbcode_text = global.markov.generate_sentence() + "\n" + global.markov.generate_sentence()
	
	var font_number = $'../Envelope'.font_number
	var new_font = DynamicFont.new()
	new_font.font_data = load('res://handwritten%s.ttf' % font_number)
	var address = get_node("../Address")
	new_font.set_size($'../Envelope'.font_sizes[font_number - 1])
	new_font.use_filter = true
	new_font.use_mipmaps = true
	$RichTextLabel.add_font_override("normal_font", new_font)

func _on_RichTextLabel_meta_clicked(meta):
	pass


func _on_RichTextLabel_gui_input(event):
	print(event)
	pass # Replace with function body.
