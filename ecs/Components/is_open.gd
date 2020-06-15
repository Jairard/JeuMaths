extends Component

class_name IsOpenComponent

var shop = false
var stats = false
var hide_health = false

func get_shop() -> bool:
	return shop

func set_shop(_bool : bool) -> void:
	shop = _bool

func get_stats() -> bool:
	return stats

func set_stats(_bool : bool) -> void:
	stats = _bool

func get_hide_health() -> bool:
	return hide_health

func set_hide_health(_bool : bool) -> void:
	hide_health = _bool
