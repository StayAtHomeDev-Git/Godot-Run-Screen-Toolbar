@tool

extends Control

signal screen_updated

var settings
var default_color : Color = Color("777777")
var active_color : Color = Color("FFFFFF")
var screen_buttons : Array = ["Screen1","Screen2","Screen3"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings = EditorInterface.get_editor_settings()
	settings.settings_changed.connect(get_current_settings)
	get_current_settings()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_current_settings() -> void:
	var current_screen = settings.get_setting("run/window_placement/screen")
	var fullscreen_mode = settings.get_setting("run/window_placement/rect")
	for i in screen_buttons:
		find_child(i).modulate = default_color
	match current_screen:
		0:
			find_child("Screen1").modulate = active_color
		1:
			find_child("Screen2").modulate = active_color
		2:
			find_child("Screen3").modulate = active_color
	match fullscreen_mode:
		4:
			find_child("Fullscreen").modulate = active_color
		1:
			find_child("Fullscreen").modulate = default_color
		_:
			find_child("Fullscreen").modulate = default_color
		

func update_run_screen(screen, button) -> void:
	var current_button = find_child(button) as TextureButton
	current_button.modulate = active_color
	settings.set_setting("run/window_placement/screen", screen)

# 1 - Centered; 4 - Force Fullscreen
func update_run_screen_size(state: bool, button) -> void:
	var current_button = find_child(button) as TextureButton
	match state:
		true:
			settings.set_setting("run/window_placement/rect", 4)
			current_button.modulate = active_color
		false:
			settings.set_setting("run/window_placement/rect", 1)
			current_button.modulate = default_color
			
func on_button_hover(button) -> void:
	var current_button = find_child(button) as TextureButton
	current_button.modulate = settings.get_setting("interface/theme/accent_color")

func on_button_unhover(button) -> void:
	var current_button = find_child(button) as TextureButton
	if current_button.button_pressed == false:
		current_button.modulate = default_color	

func update_button_color(toggled_on: bool, button) -> void:
	var current_button = find_child(button) as TextureButton
	match toggled_on:
		true:
			current_button.modulate = active_color
		false:
			current_button.modulate = default_color
