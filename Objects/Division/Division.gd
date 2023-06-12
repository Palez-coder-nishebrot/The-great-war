extends Node


var chars: Dictionary = {
	"Атака":      0,
	"Оборона":    0,
	"Дисциплина": 0,
	"Разведка":   0,
	"Скорость":   0,
}

var list_of_battalions: Array      = []
var player:             Object
var province:           Object
var game:               Object
var point:              Object

var bonuses_of_units:   Dictionary = {}


func start_training():
	province.training_units = self
	var time = 0
	
	while time != 3:
		await game.new_day
		time = time + 1
	
	province.training_units = null
	province.division_entered_in_province(self)
	move()


func set_chars():
	for battalion in list_of_battalions:
		for characteristic in chars:
			chars[characteristic] += battalion.chars[characteristic]


func set_path(_point_):
	var part_of_path = province
	var path = []
	var lock_tiles = []
	while part_of_path != _point_:
		lock_tiles.append(part_of_path)
		part_of_path = find_closed_tile(part_of_path, lock_tiles, _point_)
		path.append(part_of_path)
		
		if part_of_path == Node2D:
			return

	point = _point_
	

func find_closed_tile(tile, lock_tiles, _point_): #Самый близкий тайл
	var distance = {
		dist = tile.position.distance_to(_point_.position),
		tile = tile,
	}
	
	if tile.list_of_neighbors_tiles.has(_point_):
		return _point_
	
	for i in tile.list_of_neighbors_tiles:
		if i != distance.tile and not lock_tiles.has(i):
			if _point_.position.distance_to(i.position) < distance.dist:
				distance.tile = i
				distance.dist = _point_.position.distance_to(i.position)
	
	if distance.tile == tile:
		return Node2D
		
	else: 
		return distance.tile


func move_to_tile(tile):
	province.division_exited_in_province(self)
	
	tile.division_entered_in_province(self)
	
	province = tile
	

func move():
	await game.new_day
	
	if point != null and province != point:
		move_to_tile(find_closed_tile(province, [], point))
	
	move()
