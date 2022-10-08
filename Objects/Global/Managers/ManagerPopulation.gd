extends Node

#var call_func: Dictionary = {
#	"Рабочие_места":     "",
#	"Фабричный_рабочий": "",
#	"Образованность":    "",
#	"Коммунисты":        "",
#	"Ремесленники_в_регионе": "",
#}

const chances: Dictionary = {
	"Рабочий": {
		"Есть_рабочие_места":     {true: -100, false: 60},
		"Фабричный_рабочий": {true: 20, false: -100},
		#"Полит_реформы":     {true: 1,  false: 0},
	},
	
	"Фабричный рабочий": {
		"Образованность": {true: 40, false: -5},
		"Нет_рабочих_мест":  {true: -100, false: 40},
		"Хватает_рабочих":{true: 0, false: -100}
		#"Полит_реформы":  {true: 2,  false: 0},
		
	},
	
	"Ремесленник": {
		#"Образованность": {true: -10, false: 10},
		#"Полит_реформы":  {true: 2,   false: 0},
		"Есть_рабочие_места":  {true: -100, false: 20},
		"Коммунисты":     {true: -100, false: 0},
		"Ремесленники_в_регионе": {true: -100, false: 20},
		"Хватает_рабочих":{true: 0, false: -100}
	}
}


const paths_of_social_migration: Dictionary = {
	"Рабочий": ["Фабричный рабочий"],
	"Фабричный рабочий": ["Рабочий", "Ремесленник"],
	"Ремесленник": ["Рабочий"]
}


func set_social_migration(client):
	pass
#	for province in client.list_of_tiles:
#		var pop_manager = province.population_manager
#		var chances_for_soc_migration = {
#			"Рабочий":           0,
#			"Фабричный рабочий": 0,
#			"Ремесленник":       0,
#		}
#		for z in chances_for_soc_migration:
#			var chances_list = chances[z]
#			for y in chances_list:
#				match y:
#					"Есть_рабочие_места":
#						chances_for_soc_migration[z] += chances_list[y][check_workplaces(pop_manager)]
#
#					"Нет_рабочих_мест":
#						chances_for_soc_migration[z] += chances_list[y][check_workplaces2(pop_manager)]
#
#					"Фабричный_рабочий":
#						chances_for_soc_migration[z] += chances_list[y][check_soc_class(pop_manager, "list_of_factory_workers")]
#
#					"Образованность":
#						 chances_for_soc_migration[z] += chances_list[y][check_education(pop_manager)]
#
#					"Коммунисты":
#						chances_for_soc_migration[z] += chances_list[y][check_ruling_ideology(pop_manager, "Коммунисты")]
#
#					"Ремесленники_в_регионе":
#						chances_for_soc_migration[z] += chances_list[y][check_craftsmen(pop_manager)]
#
#					"Хватает_рабочих":
#						chances_for_soc_migration[z] += chances_list[y][check_workers(pop_manager)]
#
#		var chances_ = ["Рабочий", -500]
#		for i in chances_for_soc_migration:
#			if chances_for_soc_migration[i] > chances_[1]:
#				chances_[0] = i
#				chances_[1] = chances_for_soc_migration[i]
#
#		if Functions.rng(1, 100) <= chances_[1]:
#			change_soc_class(pop_manager, chances_[0])


func change_soc_class(pop_manager, soc_class):
	match soc_class:
		"Рабочий":
			change_soc_class_to_worker(pop_manager, soc_class)
		"Фабричный рабочий":
			change_soc_class_to(pop_manager, soc_class, "list_of_factory_workers", "list_of_workers")
		"Ремесленник":
			if pop_manager.list_of_craftsmen.size() > 0:
				breakpoint
			change_soc_class_to(pop_manager, soc_class, "list_of_craftsmen", "list_of_workers")


func change_soc_class_to_worker(pop_manager, soc_class):
	if pop_manager.list_of_craftsmen.size() > 0:
		change_soc_class_to(pop_manager, soc_class, "list_of_workers", "list_of_craftsmen")
		pop_manager.list_of_craftsmen.erase(pop_manager.list_of_craftsmen[0])
	else:
		change_soc_class_to(pop_manager, soc_class, "list_of_workers", "list_of_factory_workers")


func change_soc_class_to(pop_manager, soc_class, list_append, list_erase):
	var worker = pop_manager.get(list_erase)[0]
	worker.soc_class = soc_class
	
	pop_manager.get(list_append).append(worker)
	pop_manager.get(list_erase).erase(worker)
	
	if soc_class == "Ремесленник":
		pop_manager.province.player.list_of_craftsmen.append(worker)


func check_workers(pop_manager):
	return pop_manager.list_of_workers.size() > 1


func check_workplaces2(pop_manager):
	return pop_manager.province.workplaces - pop_manager.list_of_factory_workers.size() <= 0


func check_workplaces(pop_manager):
	return pop_manager.province.workplaces - pop_manager.list_of_factory_workers.size() > 0


func check_soc_class(pop_manager, soc_class):
	return pop_manager.get(soc_class).size() != 0


func check_education(pop_manager):
	return pop_manager.list_of_households_with_education.size() / 2 >= pop_manager.list_of_soc_classes.size()


func check_ruling_ideology(pop_manager, ideology):
	return pop_manager.province.player.policy["Правящая_партия"].ideology == ideology


func check_craftsmen(pop_manager):
	return pop_manager.list_of_craftsmen.size() > 0


func check_politic_refoms(client):
	var points = 0
	for i in Reforms.pol_reforms:
		points += client.adopted_reforms[i]
	return points
