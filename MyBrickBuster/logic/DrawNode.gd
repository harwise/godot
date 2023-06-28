extends Node2D

@onready var game_control = get_tree().get_root().get_node("MainGame")

func _ready():
	pass

func _process(_delta):
	queue_redraw() # Update _draw

func _draw():
	if game_control.get("drag_enabled") && game_control.get("draw_touch_marker"):
		# Touch/click marker
		draw_circle(game_control.get("first_click_position"), 25, Color("white", 0.5))
