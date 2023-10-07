extends Node

var countries_INTERNAL = []

var province_scene = preload("res://Scenes/province.tscn")

func _ready():	
	# FOR IMPORTER
	# deserialize provinces
	var data = _deserialize_provinces("provincesExported.json")
	for i in data:
		### add provinces
		var province_instance = province_scene.instantiate()
		province_instance.province_name = i.name
		province_instance.shape = i.shape
		province_instance.country = i.country.name
		
		if i.color != null:
			if i.color.size() == 4:
				# case where we provided RGBA
				var color = Color( float(i.color[0])/255, float(i.color[1])/255, float(i.color[2])/255, 255 )
				province_instance.color = color
			if i.color.size() == 3:
				# case where we provided RGB only
				province_instance.color = Color( float(i.color[0])/255, i.color[1]/255, i.color[2]/255 )
		else:
			print( "### FIX IT ### {name} has no Color".format({ "name": i.name }) )
		add_child(province_instance)
		
		### add countries
		_deserialize_countries()
		if not countries_INTERNAL.has(province_instance.country):
			countries_INTERNAL.append(province_instance.country)
			
	print( countries_INTERNAL )


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
	# return proper Dict
	return data

func _deserialize_countries():
	pass
