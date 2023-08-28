extends Node2D

var points = PackedVector2Array(
		[Vector2(0, 0), Vector2(600, 600), Vector2(400, 200)]
	);
var province_polygon = Polygon2D.new();


# Called when the node enters the scene tree for the first time.
func _ready():
	province_polygon.polygon = points
	province_polygon.color = Color(1.0, 0, 0, 1)
	add_child(province_polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	province_polygon.polygon[2] += Vector2(0.2, 0.1)
	
