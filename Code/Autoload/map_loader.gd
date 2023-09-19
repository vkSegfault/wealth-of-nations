extends Node

var countries_JSON = {
	"Poland": { "capital": "Warsaw", "color": Color(1, 0, 0) },
	"Germany":{ "capital": "Berlin", "color": Color(0, 1, 0) }
}
var countries_INTERNAL = []

var province_scene = preload("res://Scenes/province.tscn")
var provinces_INTERNAL = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# serialize countries
#	for country in countries_JSON:
#		#print(country)
##		print(countries_JSON[country]) # print key
##		print(countries_JSON[country]["capital"]) # print value
##		print(countries_JSON[country]["color"]) # print value
#		countries_INTERNAL.append( Country.new( country, countries_JSON[country]["capital"], countries_JSON[country]["color"] ) )
#	print("We serialized {c} countries".format({"c": countries_INTERNAL.size() }))
	
	
	# FOR IMPORTER
	# deserialize provinces
	var data = _deserialize_provinces("provincesExported.json")
	for i in data:
		var province_instance = province_scene.instantiate()
		province_instance.province_name = i.name
		province_instance.shape = i.shape
		if i.color != null:
			if i.color.size() == 4:
				# case where we provided RGBA
				var color = Color( float(i.color[0])/255, float(i.color[1])/255, float(i.color[2])/255, float(i.color[3])/255 )
				province_instance.color = color
			if i.color.size() == 3:
				# case where we provided RGB only
				province_instance.color = Color( float(i.color[0])/255, i.color[1]/255, i.color[2]/255)
		else:
			print( "### FIX IT ### {name} has no Color".format({ "name": i.name }) )
		add_child(province_instance)
	
	
	# FOR EXPORTER OF PROVINCES
	# iterate over all drew in editor provinces and make actual logical Province out of vertices
#	for i in get_node("/root/Root/WorldDrawDebug/Node2D").get_children():
#
#		# if it's not Polygon2D then it's some debug temp shit probably and we don't care
#		if not (i is Polygon2D):
#			continue
#
#		var name = i.name
#		var shape = i.polygon
#		provinces_INTERNAL.append( { "name" = name, "shape" = shape } )
##		print("Province: {p} with coords: {c}".format({"p": i.name, "c": i.polygon}))
#
##		var province_instance = province_scene.instantiate()
##		province_instance.province_name = i.name
##		province_instance.shape = i.polygon
##		# this if check ensures that name from godot internal provinces matches ones from external DB
##		# THERE SHOULD NEVER BE else PATH EXECUTED! if so fix the data (probablu Province name mismatch)
##		# i.name - name of Province from internal Godot map
##		# provinces_JSON.keys() - name of Province from dict DB
##		if i.name in provinces_DICT.keys():
##			print("Province: {p} is in province dictionary".format({"p": i.name}))
##			var country = provinces_DICT[i.name]["country"]
##			province_instance.country = country
##			var country_color = countries_JSON[country]["color"]
##			province_instance.color = country_color
##			var pop = provinces_DICT[i.name]["pop"]
##			province_instance.pop = pop
##		else:
##			print("### FIX IT ### Province: {p} is NOT in province dictionary".format({"p": i.name}))
##
##		add_child(province_instance)
#
#	print("We serialized {p} provinces".format({"p": provinces_INTERNAL.size() }))
	
	# iterare provinces and add to country it belongs to
	# for prov in provinces_INTERNAL:
	#	#
	# 	prov.color = countries_JSON[ province_INTERNAL[prov][country] <- this give us country name ][color]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _deserialize_provinces(file_name: String):
	var prov_file = FileAccess.open(file_name, FileAccess.READ)
	var data = JSON.parse_string(prov_file.get_as_text())
	for i in data:
		var vector_as_string = i.shape
		vector_as_string = vector_as_string.substr(1, len(vector_as_string) - 2)
		var array_of_string_vec2s = vector_as_string.split("),")
		
		# convert stringified list of shape vectors to PackedList
		var shape = PackedVector2Array()
		for vec2_str in array_of_string_vec2s:
			vec2_str = vec2_str.replace(" (", "")
			vec2_str = vec2_str.replace("(", "")
			vec2_str = vec2_str.replace(",", "")
			vec2_str = vec2_str.split(" ")
			var vec2_int = Vector2( int(vec2_str[0]), int(vec2_str[1]) )
			shape.append(vec2_int)
		i.shape = shape
	prov_file.close()
	return data
