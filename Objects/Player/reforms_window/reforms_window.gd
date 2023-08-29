extends Panel


@onready var reform_panel: Panel = $reform_panel
@onready var info_label_1: Label = $reform_list_ScrollContainer/reform_list_container/info_label
@onready var info_label_2: Label = $reform_list_ScrollContainer/reform_list_container/info_label2
@onready var info_label_3: Label = $reform_list_ScrollContainer/reform_list_container/info_label3
@onready var info_label_4: Label = $reform_list_ScrollContainer/reform_list_container/info_label4
@onready var info_label_5: Label = $reform_list_ScrollContainer/reform_list_container/info_label5

var soc_refoms_avaliable: bool = false
var pol_refoms_avaliable: bool = false

var back_soc_refoms_avaliable: bool = false
var back_pol_refoms_avaliable: bool = false


func update_information():
	var government = Players.get_player_client().reforms_manager.government
	
	soc_refoms_avaliable      = government.soc_refoms_avaliable
	pol_refoms_avaliable      = government.pol_refoms_avaliable
	back_soc_refoms_avaliable = government.back_soc_refoms_avaliable
	back_pol_refoms_avaliable = government.back_pol_refoms_avaliable
	
	update_reforming_opportunity_info(government.days_before_opportunity_reform)
	
	if reform_panel.reform_cotegory != null:
		reform_panel.update_info(reform_panel.reform_cotegory)
	

func update_reforming_opportunity_info(recharging_days):
	info_label_1.text = "Пров-е соц. реформ: " + str(soc_refoms_avaliable)
	info_label_2.text = "Пров-е пол. реформ: " + str(pol_refoms_avaliable)
	info_label_3.text = "Откат соц. реформ: " + str(back_soc_refoms_avaliable)
	info_label_4.text = "Откат пол. реформ: " + str(back_pol_refoms_avaliable)
	info_label_5.text = "Реформы будут доступны через " + str(recharging_days) + " дн."
	pass


func update_reform_info(reform: ReformCotegory):
	reform_panel.update_info(reform)
