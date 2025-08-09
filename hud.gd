extends CanvasLayer

@onready var health_bar = $Healthbar

var max_health = 5
var current_health = 5

func set_health(value: int):
	current_health = clamp(value, 0, max_health)
	# Load the correct image based on health
	var texture_path = "res://assets/Healthbar/Healthbar_%d.png" % current_health
	health_bar.texture = load(texture_path)

func show_message(text: String, color: Color):
	var label = Label.new()
	label.text = text
	label.add_theme_color_override("font_color", color)
	label.set("theme_override_font_sizes/font_size", 48)
	label.anchor_left = 0.5
	label.anchor_top = 0.5
	label.offset_left = -100
	label.offset_top = -24
	add_child(label)
