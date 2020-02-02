extends Node2D

var stats : Array = []
var dict = {}
var file = File.new()
var init_stats : Dictionary = {
							"pseudo" : "",
							"stats" : [
										{
										"damage":15,"health":70,"level":0,
										"xp":0,"treasure":0,"good_answer":1,
										"wrong_answer":1,"boss_killed":1
										}
									  ]
						}

func _ready():
	pass

#func _process(delta):
#	pass

func if_pseudo():
	for i in len(stats):
		print (stats[i]["pseudo"])
		if stats[i]["pseudo"] == $TileMap/pseudo.get_text():
			print ("load")
			_load()
		else :
			print ("save")
			stats.append(init_stats)
			save()

func _on_Button_pressed():
	
	var pseudo : String = $TileMap/pseudo.get_text()
	if_pseudo()

	get_tree().change_scene("res://Src/Outgame/create_hero.tscn")

func _load():
	
	file.open("res://log_in/pseudo.json", File.READ)
	dict = parse_json(file.get_as_text())
	file.close()
		
func save():
	
	file.open("res://Assets/Stats_Characters/Hero_Stats.json", File.WRITE)
	var text = to_json(init_stats)
	file.store_string(text)
	file.close()
	
	
	