extends Node

var people = null
var markov = null

func import_json(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json)
	file.close()
	return json_result.result


func generate_sentence():
	var sentence = markov.generate_sentence()
	return sentence.replace('<', '[').replace('>', ']')

func cache_load():
	var file = File.new()
	for i in range(0, 20):
		for f in ['envelope_%s.png', 'envelope_%s_torn.png', 'stamp%s.png', 'cancellation%s.png', 'handwritten%s.png']:
			if file.file_exists(f % i):
				print('preloading ' + f % i)
				load(f % i)
	
func _ready():	
	people = import_json('res://people.json')
	markov = Markov.new()
	markov.load('res://model.json')
	cache_load()