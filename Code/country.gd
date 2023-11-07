extends Node
class_name Country

var _name: String
var _capital: String
var _color: Color
var _production: Dictionary = {} # e.g.: { "fish": 12, "cars": 3 }
var _demand: Dictionary = {}  # e.g.: { "fish": 12, "cars": 3 }, country demand comes from domestic factories
var _stock: Dictionary = {}  # if we produce we can save it in stockpile instead providing on the market (but we won't get paid), if we don't produce we can buy it
var _resources_to_stock: Array = []
var _pop: int

# ctor
func _init( country_name, capital = "NOT PROVIDED", color = Color() ):
	_name = country_name
	_capital = capital
	_color = color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass
