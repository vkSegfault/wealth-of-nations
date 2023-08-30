extends Node

var province_name: String = "NOT PROVIDED"
var shape = PackedVector2Array()

func _ready():
	var pol2d = $Node2D/Polygon2D
	pol2d.polygon = shape
	if province_name == "Pomerania":
		$Node2D/Polygon2D.apply_scale(Vector2(0.95, 0.95))	
	add_collision_polygon_2d(pol2d.polygon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	print("Entered {p}".format({"p": province_name }))
	
	# example uf using global variable from autoloaded singleton code
	print(MapLoader.GLOBAL)

func add_collision_polygon_2d(collision_shape: PackedVector2Array):
	# create CollisionPolygon2D needed for on_mouse_entered() signal of Area2D from exact vertices of Polygon2D itself
	var collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = collision_shape
	$Node2D/Polygon2D/Area2D.add_child(collision_polygon_2d)
