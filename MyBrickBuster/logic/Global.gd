extends Node

# IMPORTANT NOTE: WHEN EXPORTING, MAKE SURE SCRIPT FILES ARE EXPORTED AS TEXT
# AND NOT COMPILED, OTHERWISE THERE WILL BE ISSUES WITH THE BALL AND GAMEMODE
# FETCHER FUNCTIONS.
# Project -> Export -> (select preset) -> Script -> Script Export Mode -> Text

#var save_game = File.new()
var save_game_data = null
var rng = RandomNumberGenerator.new()
var noto_font = load("res://styling/fonts/NotoSans.tres")
var noto_font_bold = load("res://styling/fonts/NotoSans_Bold.tres")
var noto_font_bold_title = load("res://styling/fonts/NotoSans_Bold_Title.tres")

# We use this to present the user with a popup explaining how the game works
# if it's their first time playing.
var first_run = false
# The selected ball is read from the config file.
var selected_ball_scene = null
var current_mode = null

var game_modes = {}
var ball_scenes = []

# These colour themes are for bricks
var colour_themes = {
	"sunburst": {
		"display_name": "Sunburst",
		"top_health": Color("#ff3300"),
		"bottom_health": Color("#ffe600")
	},
	"supernova": {
		"display_name": "Supernova",
		"top_health": Color("#5500ff"),
		"bottom_health": Color("#00e1ff")
	},
	"aurora": {
		"display_name": "Aurora",
		"top_health": Color("#1f4037"),
		"bottom_health": Color("#99f2c8")
	},
	"nebula": {
		"display_name": "Nebula",
		"top_health": Color("#FC466B"),
		"bottom_health": Color("#3F5EFB")
	},
	"pulsar": {
		"display_name": "Pulsar",
		"top_health": Color("#16A085"),
		"bottom_health": Color("#F56217")
	},
	"quasar": {
		"display_name": "Quasar",
		"top_health": Color("#F4D03F"),
		"bottom_health": Color("#0B486B")
	}
}

# We set these to defaults in case there is nothing set in the config file.
# This should be caught by the ready() function, however. 
var selected_standard_theme = "sunburst"
var selected_mega_theme = "supernova"

func reload_selected_ball():
	selected_ball_scene = load("res://scenes/Balls/" + "Ball.tscn")

# Gets the balls according to the files found in /scenes/Balls/. 
func fetch_balls():
	var path = "res://scenes/Balls/"
	var ball_scenes_dir = DirAccess.open(path)
	ball_scenes_dir.list_dir_begin()

	while true:
		var file_name = ball_scenes_dir.get_next()
		if file_name == "":
			break
		elif not file_name.begins_with("."):
			var ball_scene = load(path + file_name)
			ball_scenes.append({"filename": file_name, "ball_scene": ball_scene})

	ball_scenes_dir.list_dir_end()
	
	
# Gets the gamemodes according to the files found in /logic/GameModes/. 
func fetch_game_modes():
	var path = "res://logic/GameModes/"
	var game_modes_dir = DirAccess.open(path)
	game_modes_dir.list_dir_begin()

	while true:
		var file_name = game_modes_dir.get_next()
		print(file_name)
		if file_name == "":
			break
		elif not file_name.begins_with("."):
			var game_mode_file = load(path + file_name)
			var holder_node = Node2D.new()
			holder_node.set_script(game_mode_file)
			var game_mode_details = holder_node.game_mode_details
			game_modes[game_mode_details["name"]] = {}
			game_modes[game_mode_details["name"]]["path"] = path + file_name
			game_modes[game_mode_details["name"]]["name"] = game_mode_details.name
			game_modes[game_mode_details["name"]]["display_name"] = game_mode_details.display_name
			game_modes[game_mode_details["name"]]["description"] = game_mode_details.description
	game_modes_dir.list_dir_end()

# Writes user-set theme for bricks from the config file to the global variables
# read by the rest of the game.
func set_theme():
	#selected_standard_theme = "standard_bricks"
	#selected_mega_theme = "mega_bricks
	pass

func _ready():
	first_run = false
		
	#AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), config.get_value("audio", "volume") == 0)
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), config.get_value("audio", "volume"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 10)
	
	fetch_game_modes()
	fetch_balls()
	reload_selected_ball()
	set_theme()

