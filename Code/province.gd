extends Node

var province_name: String = "NOT PROVIDED"
var shape = PackedVector2Array()
const BORDER_DEFAULT_COLOR = Color(1, 0, 0, 1)

func _ready():
	var pol2d = $Node2D/Polygon2D
	pol2d.polygon = shape
	add_collision_polygon_2d(pol2d.polygon)
	add_border(pol2d.polygon)  # note comment inside func

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	print("Entered {p}".format({"p": province_name }))
	$Node2D/Polygon2D/Line2D.default_color = Color(0, 0, 1, 1)

func _on_area_2d_mouse_exited():
	$Node2D/Polygon2D/Line2D.default_color = BORDER_DEFAULT_COLOR

func add_collision_polygon_2d(collision_shape: PackedVector2Array):
	# create CollisionPolygon2D needed for on_mouse_entered() signal of Area2D from exact vertices of Polygon2D itself
	var collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = collision_shape
	$Node2D/Polygon2D/Area2D.add_child(collision_polygon_2d)

func add_border(line_shape: PackedVector2Array):
	# there is open request to enable closing Line2D, for not it stays open
	# https://github.com/godotengine/godot/pull/79182
	var line = $Node2D/Polygon2D/Line2D
	line.points = line_shape
	line.width = 4
	line.default_color = Color(1, 0, 0, 1)
	line.z_index = 1  # to draw on top of province
	line.antialiased = true
	$Node2D/Polygon2D.add_child(line)
	print("Line2D points count: {c}".format({ "c": line.get_point_count() }))

