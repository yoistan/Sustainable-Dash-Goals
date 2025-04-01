extends Marker2D

const RECT_SIZE := Vector2(15, 15) 

func _draw() -> void:
	draw_rect(Rect2(-RECT_SIZE / 2, RECT_SIZE),Color.TRANSPARENT)

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	
func deselect():
	pass
