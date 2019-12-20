extends Component

class_name CharacterstatsComponent

var stats 	: Dictionary = {}
var health 	: int = 0
var xp 		: int = 0
var level 	: int = 0
var damage 	: int = 0
var load_hero_stats = load_c("res://Assets/Stats_Characters/Hero_Stats.json")

func get_stats() -> Dictionary:
	return stats
	
func set_stats(_stats : Dictionary) -> void:
	stats = _stats

func load_c(path : String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	stats = parse_json(text)
	file.close()
	return stats

func init_stats() -> void:
	health 	= stats["health"]
	damage 	= stats["damage"]
	xp 		= stats["xp"]
	level 	= stats["level"]