extends Panel

var reform_cotegory: ReformCotegory

@onready var reform_name:    Label = $reform_name
@onready var next_level:     Label = $next_level
@onready var previous_level: Label = $previous_level
@onready var this_level:     Label = $this_level

@onready var to_reform:        Button = $buttons/to_reform
@onready var roll_back_reform: Button = $buttons/roll_back_reform


func update_info(reform: ReformCotegory):
	reform_cotegory = reform
	var reform_level = reform_cotegory.level
	
	update_buttons(reform_cotegory.level, reform_cotegory.max_level)
	next_level.text     = "След. реформа" + "\n"
	previous_level.text = "Пред. реформа" + "\n"
	this_level.text     = "Нынешняя реформа дает нам:" + "\n"
	
	reform_name.text = reform_cotegory.reform.reform_name
	
	level_update_info(reform_cotegory.reform.levels[reform_level], this_level)

	if reform_level + 1 <= reform_cotegory.max_level:
		level_update_info(reform_cotegory.reform.levels[reform_level + 1], next_level)
	
	if reform_level != 0:
		level_update_info(reform_cotegory.reform.levels[reform_level - 1], previous_level)
	

func level_update_info(reform_level: ReformLevel, label: Label):
	var dict = reform_level.get_data()
	for i in reform_level.get_data():
		label.text += tr(i) + ": " + str(dict[i]) + "\n"
	

func update_buttons(level, max_level):
	to_reform.update(level, max_level, reform_cotegory.reform.reform_type)
	roll_back_reform.update(level, reform_cotegory.reform.reform_type)


func clear_label(label: Label):
	label.text = ""


func to_reform_():
	reform_cotegory.to_reform(Players.get_player_client())
	update_info(reform_cotegory)
	disable_buttons()


func roll_back_reform_():
	reform_cotegory.roll_back_reform(Players.get_player_client())
	update_info(reform_cotegory)
	disable_buttons()
	


func disable_buttons():
	to_reform.disabled        = true
	roll_back_reform.disabled = true
