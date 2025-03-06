extends Node2D

var selected = false
var rest_point: Vector2
var rest_nodes = []

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	
	# Ensure there is at least one valid zone
	if rest_nodes.size() > 0:
		rest_point = rest_nodes[0].global_position  # Set default rest point
	else:
		rest_point = global_position  # Use object's current position as fallback

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		selected = true  # Start dragging

func _physics_process(delta):
	if rest_point:  # Ensure rest_point is valid
		if selected:
			global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
			look_at(get_global_mouse_position())
		else:
			global_position = lerp(global_position, rest_point, 15 * delta)
			rotation = lerp_angle(rotation,0, 10 * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
		selected = false  # Stop dragging
		var shortest_dist = 75
		var closest_zone = null

		for child in rest_nodes:
			var distance = global_position.distance_to(child.global_position)
			if distance < shortest_dist:
				shortest_dist = distance
				closest_zone = child

		if closest_zone:
			rest_point = closest_zone.global_position  # Snap to closest zone
