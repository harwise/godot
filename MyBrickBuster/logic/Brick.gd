extends RigidBody2D

signal brick_killed(brick)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var health = null
var mega = null
var max_possible_health = null
var hit = false
var column_num = null
var column_vert_point = null

var gradient = Gradient.new()

@onready var global = get_node("/root/Global")
@onready var brick_shape = $BrickShape
@onready var label = $HealthLabel
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 0.3
	if mega:
		gradient.set_color(1, global.colour_themes[global.selected_mega_theme].top_health)
		gradient.set_color(0, global.colour_themes[global.selected_mega_theme].bottom_health)
		health *= 2
		max_possible_health *= 2
	else:
		gradient.set_color(1, global.colour_themes[global.selected_standard_theme].top_health)
		gradient.set_color(0, global.colour_themes[global.selected_standard_theme].bottom_health)
	self.modulate.a = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	label.text = str(health)
	brick_shape.color = gradient.sample(float(health)/float(max_possible_health))
	$Light2D.color = brick_shape.color
	
	if health <= 0:
		$Collision2D.disabled = true
		if self.modulate.a > 0:
			self.modulate.a -= 0.05
		else:
			self.queue_free()
			emit_signal("brick_killed", self)
	else:
		if self.modulate.a < 1:
			self.modulate.a += 0.05
	
	if hit:
		self.modulate.a = 0.5
		self.hit = false

