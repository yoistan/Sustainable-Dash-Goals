extends Marker2D

func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color.BEIGE)

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.CORNFLOWER_BLUE
	
func deselect():
	modulate = Color.WHITE
