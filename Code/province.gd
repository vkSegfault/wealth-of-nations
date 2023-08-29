extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# create CollisionPolygon2D needed for on_mouse_entered() signal of Area2D from exact vertices of Polygon2D itself
	var vertices: PackedVector2Array = self.polygon
	var collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = vertices
	$Area2D.add_child(collision_polygon_2d)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	print("Entered Area2D")
	
	# example uf using global variable from autoloaded singleton code
	print(MapLoader.GLOBAL)
