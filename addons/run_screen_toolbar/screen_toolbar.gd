@tool
extends EditorPlugin

var toolbar

func _enter_tree() -> void:
	toolbar = preload("res://addons/run_screen_toolbar/screen_toolbar.tscn").instantiate()
	
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, toolbar)

func _exit_tree() -> void:
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, toolbar)
	
	toolbar.free()

func _make_visible(visible):
	toolbar.visible = visible
