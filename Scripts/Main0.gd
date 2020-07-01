extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var admob = $Admob

# Called when the node enters the scene tree for the first time.
func _ready():
	# Replace with function body.
	admob.load_banner()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Admob_banner_failed_to_load(error_code):
	pass # Replace with function body.

func _on_Admob_banner_loaded():
	pass # Replace with function body.
