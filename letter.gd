extends Node2D

var opened = false
var paper = null

func _ready():
	paper = $Paper
	remove_child(paper)


func open():
	if not opened:
		$Envelope.open()
		opened = true
		add_child(paper)
