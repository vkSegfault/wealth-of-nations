extends Node

func _ready():
	
	var prov_json = JSON.stringify(MapLoader.provinces_INTERNAL)
	var prov_file = FileAccess.open("provinces.json", FileAccess.WRITE)
	prov_file.store_line(prov_json)
	prov_file.close()
	
	for p in MapLoader.provinces_INTERNAL:
		print(p)
		print(MapLoader.provinces_INTERNAL[p])
		
	
