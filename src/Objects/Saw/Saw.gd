extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "rotation_degrees",
			0, 360, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
