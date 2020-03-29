extends Node

func create_label(position : Vector2, rect_size : Vector2, color : Color, 
				  font : String, font_size : int, font_outline_size : int, font_outline_color : Color) -> Label:

	var dynamic_font_timer = DynamicFont.new()
	dynamic_font_timer.font_data = load(font)
	dynamic_font_timer.size = font_size
	dynamic_font_timer.outline_size = font_outline_size
	dynamic_font_timer.outline_color = font_outline_color
	dynamic_font_timer.use_filter = true

	var label = Label.new()
	label.show()				
	label.set_position(position)				
	label.rect_size.x = rect_size.x
	label.rect_size.y = rect_size.y
	label.align = VALIGN_CENTER
	label.add_font_override("font", dynamic_font_timer)
	label.add_color_override("font_color", color)

	return label


func create_timer(time : int, one_shot : bool, auto_start : bool) -> Timer:

	var timer = Timer.new()

	timer.set_wait_time(time)	
	timer.set_one_shot(one_shot)
	timer.set_autostart(auto_start)
	timer.start()
	
	return timer
