extends Node

var province_scene = preload("res://Scenes/province.tscn")

func _ready():
	
	# deserialize countries
	var countries = _deserialize_countries("countriesExported.json")
	for c in countries:
		WorldState.COUNTRIES.append( Country.new( c.name, c.capital.name, Color( c.color[0], c.color[1], c.color[2] ) ) )

	# deserialize provinces
	var data = _deserialize_provinces("provincesExported.json")
	for i in data:
		### add provinces
		var province_instance = province_scene.instantiate()
		province_instance.setName( i.name )
		province_instance.shape = i.shape
		province_instance.country = i.country.name
#		if i.country is String:
#			province_instance.country = i.country.name
#		else:
#			province_instance.country = "## FIX IT ## COUNTRY NOT PROVIDED"
		print( i.country )
		
		if i.color != null:
			if i.color.size() == 4:
				# case where we provided RGBA
				var color = Color( float(i.color[0])/255, float(i.color[1])/255, float(i.color[2])/255, 255 )
				province_instance.color = color
			if i.color.size() == 3:
				# case where we provided RGB only
				province_instance.setColor( Color( float(i.color[0])/255, i.color[1]/255, i.color[2]/255 ) )
		else:
			print( "### FIX IT ### {name} has no Color".format({ "name": i.name }) )
		add_child(province_instance)
		WorldState.PROVINCES.append( province_instance )
	
	_gather_pop_from_provinces_to_countries( data )
	_gather_production_from_provinces_to_countries( data )


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
		
		# if Country is not assigned to Province (it's <null> instead { 'name': 'Poland' }
		if not i.country is Dictionary:
			print( "### FIX IT ### Province without Country: " + i.name )
			i.country = { 'name': "### MISSING COUNTRY ###" }
			
	prov_file.close()
	return data

func _deserialize_countries(file_name: String):
	var country_file = FileAccess.open(file_name, FileAccess.READ)
	var data = JSON.parse_string(country_file.get_as_text())
	for i in data:
		pass
	country_file.close()
	return data

func _gather_pop_from_provinces_to_countries( deserialized_provinces ):
	for p in deserialized_provinces:
		for c in WorldState.COUNTRIES:
			if c._name == p.country.name:
				c._pop += p.pop
	for c in WorldState.COUNTRIES:
		print( "{c} has {p} population in total".format({'c': c._name, 'p': c._pop}) )

func _gather_production_from_provinces_to_countries( deserialized_provinces ):
	for p in deserialized_provinces:
		for c in WorldState.COUNTRIES:
			if c._name == p.country.name:  # if province belongs to country
				if c._production.has( p.resource ):
					c._production[p.resource] += 1
	for c in WorldState.COUNTRIES:
		print( "{c} has {r}".format( { "c":c._name, "r": c._production} ) )

func get_country_instance( country_name: String ):
	for c in WorldState.COUNTRIES:
		if country_name == c._name:
			# DOES IT MAKE A COPY OR RETURNS REFERENCE???
			# it seems it's reference to original one
			return c
