extends Node2D

var points = PackedVector2Array(
		[Vector2(0, 0), Vector2(600, 600), Vector2(400, 200)]
	);
var province_polygon = Polygon2D.new();

var province_scene = preload("res://province.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	# iterate over all drawed provinces and make actual logical Province out of vertices
	for i in get_node("/root/Root/WorldDrawDebug/Node2D").get_children():
		print("Province: {p} with coords: {c}".format({"p": i.name, "c": i.polygon}))
		
		var province_instance = province_scene.instantiate()
		province_instance.get_child(0).get_child(0).province_name = i.name
		# get to the Polygon2D node
		province_instance.get_child(0).get_child(0).polygon = i.polygon
		add_child(province_instance)
	
	province_polygon.polygon = points
	province_polygon.color = Color(1.0, 0, 0, 1)
	add_child(province_polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	province_polygon.polygon[2] += Vector2(0.2, 0.1)
	
