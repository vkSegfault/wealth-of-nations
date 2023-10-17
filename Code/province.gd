extends Node

# Maybe Province should own it's own UI (?)

var _province_name: String = "NOT PROVIDED" : set = setName, get = getName
var shape = PackedVector2Array()
var _color: Color = Color(0, 0, 0, 0) : set = setColor, get = getColor
const BORDER_DEFAULT_COLOR = Color(0.4, 0.4, 0.4, 1)
const BORDER_FOCUSED_COLOR = Color(0, 0, 0, 1)
var country: String
var pop: int
var resource: String
var resource_amount: int
var terrain: String

var focused: bool = false



func _ready():
	var pol2d = $Node2D/Polygon2D
	pol2d.polygon = shape
	pol2d.color = _color
	_add_collision_polygon_2d(pol2d.polygon)
	_add_border(pol2d.polygon)  # note comment inside func
	_add_nav_polygon(pol2d.polygon)
	
	## TEMP - depening on province terrain type travel cost should be higher
	if _province_name == "WestPomerania":
		$NavigationRegion2D.travel_cost = 1
		
		### THERE ARE 2 WAYS TO BLOCK AGENTS FROM ENTERING NAV REGION:
		### 1. Using different layers so that Agents of COuntry A will only move on Layer 1
		### 2. Disabling Nav Region so we manually define that everything other than Country's Regions should be disabled
		# (SOLUTION 1) move this NavigationRegion into layer 2 so that Agent's operating on layer 1 can't use it
		# this way we can accomplish where particular Country units can go (inside our border) or can't (outside border)
		$NavigationRegion2D.set_navigation_layer_value(2, true)
		$NavigationRegion2D.set_navigation_layer_value(1, false)
		# (SOLUTION 2)
		$NavigationRegion2D.enabled = false

@warning_ignore("unused_parameter")
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if focused == true:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				print( "Province Clicked: " + _province_name )
				SignalRelay._province_clicked( _province_name, country, pop, resource, resource_amount, terrain )
	
func setName( province_name: String ):
	_province_name = province_name

func getName():
	return _province_name

func setColor( color: Color ):
	_color = color
	$Node2D/Polygon2D.color = _color

func getColor():
	return _color

func _on_area_2d_mouse_entered():
	print("Entered {p}".format({"p": _province_name }))
	var line = $Node2D/Polygon2D/Line2D
	line.default_color = BORDER_FOCUSED_COLOR
	line.z_index = 2  # to draw focused border over other borders
	focused = true
	
	# both equivalent
	# emit_signal("mouse_entered_province_signal")
	# mouse_entered_province_signal.emit()
	SignalRelay._province_name_changed(_province_name, country)
		

func _on_area_2d_mouse_exited():
	var line = $Node2D/Polygon2D/Line2D
	line.default_color = BORDER_DEFAULT_COLOR
	line.z_index = 1  # get back to normal border ordering
	focused = false

func _add_collision_polygon_2d(collision_shape: PackedVector2Array):
	# create CollisionPolygon2D needed for on_mouse_entered() signal of Area2D from exact vertices of Polygon2D itself
	var collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = collision_shape
	$Node2D/Polygon2D/Area2D.add_child(collision_polygon_2d)

func _add_border(line_shape: PackedVector2Array):
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

func _add_nav_polygon(outline: PackedVector2Array):
	var nav_polygon = NavigationPolygon.new()
	nav_polygon.add_outline(outline)
	nav_polygon.make_polygons_from_outlines()
	$NavigationRegion2D.navigation_polygon = nav_polygon
