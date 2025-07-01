extends Camera2D
const speed=3.0
func _physics_process(delta: float) -> void:
	position+=Input.get_vector("ui_left","ui_right","ui_up","ui_down")*speed
