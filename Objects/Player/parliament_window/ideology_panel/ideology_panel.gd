extends HBoxContainer


@onready var icon: TextureRect = $icon
@onready var seats:    Label   = $seats
@onready var ide_name: Label   = $ide_name


@export var ideology: Ideology
var government: Government


func _ready():
	government   = Players.get_player_client().reforms_manager.government
	icon.texture = ideology.ideology_icon
	ide_name.text = ideology.ideology
	

func update():
	seats.text = str(government.parties_seats[ideology]) + "%"
	
