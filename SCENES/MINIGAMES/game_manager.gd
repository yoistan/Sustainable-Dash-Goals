extends Node2D

var node2d_list: Array = []
var current_node: Node2D = null

func _ready():
	# Get all Node2D children and store them in the array
	for child in get_children():
		if child is Node2D:
			node2d_list.append(child)
	
	# Hide all nodes initially
	for node in node2d_list:
		node.visible = false

	# Show a random node
	show_random_node()

func show_random_node():
	# Hide current node if there is one
	if current_node:
		current_node.visible = false

	# If nodes are left, select and show one randomly
	if node2d_list.size() > 0:
		var random_index = randi() % node2d_list.size()
		current_node = node2d_list[random_index]
		current_node.visible = true
	else:
		print("All nodes have been displayed.")

func on_node_placed():
	# Remove the current node from the list
	if current_node:
		node2d_list.erase(current_node)
		current_node.queue_free()
		current_node = null

	# Show the next random node
	show_random_node()
