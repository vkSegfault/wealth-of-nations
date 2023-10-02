extends Node

#class_name Province

var province_name: String = "NOT PROVIDED"
var shape = PackedVector2Array()
var color: Color = Color(0, 0, 0, 0)
const BORDER_DEFAULT_COLOR = Color(0.4, 0.4, 0.4, 1)
const BORDER_FOCUSED_COLOR = Color(0, 0, 0, 1)
var country: String
var pop: int

# signal mouse_entered_province_signal

#func _init(country: String, pop: int):
#	country = country
#	pop = pop

func _ready():
	var pol2d = $Node2D/Polygon2D
	pol2d.polygon = shape
	pol2d.color = color
	add_collision_polygon_2d(pol2d.polygon)
	add_border(pol2d.polygon)  # note comment inside func

@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	print("Entered {p}".format({"p": province_name }))
	var line = $Node2D/Polygon2D/Line2D
	line.default_color = BORDER_FOCUSED_COLOR
	line.z_index = 2  # to draw focused border over other borders
	
	# both equivalent
	# emit_signal("mouse_entered_province_signal")
	# mouse_entered_province_signal.emit()
	SignalRelay._province_name_changed(province_name, country)

func _on_area_2d_mouse_exited():
	var line = $Node2D/Polygon2D/Line2D
	line.default_color = BORDER_DEFAULT_COLOR
	line.z_index = 1  # get back to normal border ordering

func add_collision_polygon_2d(collision_shape: PackedVector2Array):
	# create CollisionPolygon2D needed for on_mouse_entered() signal of Area2D from exact vertices of Polygon2D itself
	var collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = collision_shape
	$Node2D/Polygon2D/Area2D.add_child(collision_polygon_2d)

func add_border(line_shape: PackedVector2Array):
	# there is open request to enable closing Line2D, for now it stays open
	# https://github.com/godotengine/godot/pull/79182
	var line = $Node2D/Polygon2D/Line2D
	line.points = line_shape
	line.width = 4
	line.default_color = BORDER_DEFAULT_COLOR
	line.z_index = 1  # to draw on top of province
	line.antialiased = true
	#$Node2D/Polygon2D.add_child(line)  # it's already in tree so don't need to add child
	#print("Line2D points count: {c}".format({ "c": line.get_point_count() }))

