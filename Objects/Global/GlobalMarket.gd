extends Node

var quanity_of_goods: Dictionary = {}

var prices_of_goods:  Dictionary = {
	"Уголь":     15,
	"Железо":    15,
	"Нефть":     15,
	"Резина":    15,
	"Хлопок":    15,
	"Зерно":     15,
	"Скот":      15,
	"Селитра":   15,
	"Древесина": 15,
	"Лекарственные_растения": 10,
	
	"Сталь":     50,
	"Стекло":    50,
	"Ткань":     50,
	"Электрозапчасти": 50,
	"Автозапчасти":    50,
	"Удобрения":       50,
	"Пиломатериалы":   50,
	"Динамит":         50,
	
	"Автомобили":      100,
	"Тракторы":        15,
	"Телеграфы":       15,
	"Телефоны":        15,
	"Радио":           15,
	
	"Мебель":          15,
	"Спиртное":        15,
	"Одежда":          15,
	"Обогреватели":    15,
	"Хлеб":            30,
	"Консервы":        15,
	"Топливо":         15,
	"Табак":           15,
	"Лекарства":       10,
	"Чай":             10,
	"Кофе":            10,
	
	"Снаряды":             45,
	"Боеприпасы":          45,
	"Пулеметы":            45,
	"Артиллерия":          45,
	"Аэроплан":            45,
	"Магазинные_винтовки": 45,
	"Бронемашины":         45,
	"Танки":               45,
}

const min_and_max_prices_of_goods: Dictionary = {
	"Уголь":     {min_ = 10, max_ = 30},
	"Железо":    {min_ = 10, max_ = 30},
	"Нефть":     {min_ = 10, max_ = 30},
	"Резина":    {min_ = 10, max_ = 30},
	"Хлопок":    {min_ = 10, max_ = 30},
	"Зерно":     {min_ = 10, max_ = 20},
	"Скот":      {min_ = 10, max_ = 20},
	"Селитра":   {min_ = 10, max_ = 30},
	"Древесина": {min_ = 10, max_ = 30},
	"Лекарственные_растения": {min_ = 10, max_ = 30},
	
	"Сталь":                  {min_ = 20, max_ = 50},
	"Стекло":                 {min_ = 20, max_ = 50},
	"Ткань":                  {min_ = 20, max_ = 40},
	"Электрозапчасти":        {min_ = 20, max_ = 80},
	"Автозапчасти":           {min_ = 20, max_ = 80},
	"Удобрения":              {min_ = 20, max_ = 50},
	"Пиломатериалы":          {min_ = 20, max_ = 50},
	"Динамит":                {min_ = 20, max_ = 50},
	
	"Автомобили":             {min_ = 40, max_ = 400},
	"Тракторы":               {min_ = 40, max_ = 400},
	"Телеграфы":              {min_ = 40, max_ = 150},
	"Телефоны":               {min_ = 40, max_ = 150},
	"Радио":                  {min_ = 40, max_ = 150},
	
	"Мебель":              {min_ = 30, max_ = 60},
	"Спиртное":            {min_ = 20, max_ = 60},
	"Одежда":              {min_ = 20, max_ = 60},
	"Обогреватели":        {min_ = 30, max_ = 100},
	"Хлеб":                {min_ = 10, max_ = 40},
	"Консервы":            {min_ = 30, max_ = 60},
	"Топливо":             {min_ = 10, max_ = 60},
	"Табак":               {min_ = 10, max_ = 40},
	"Лекарства":           {min_ = 10, max_ = 40},
	"Чай":                 {min_ = 10, max_ = 30},
	"Кофе":                {min_ = 10, max_ = 40},
	
	"Снаряды":             {min_ = 30, max_ = 110},
	"Боеприпасы":          {min_ = 30, max_ = 100},
	"Пулеметы":            {min_ = 30,max_ = 250},
	"Артиллерия":          {min_ = 30,max_ = 350},
	"Аэроплан":            {min_ = 30,max_ = 300},
	"Магазинные_винтовки": {min_ = 30, max_ = 110},
	"Бронемашины":         {min_ = 30, max_ = 600},
	"Танки":               {min_ = 30, max_ = 950},
}

var demand: Dictionary = prices_of_goods.duplicate()
var supply: Dictionary = prices_of_goods.duplicate()

const goods: Dictionary = {
	"Резина": {"Уголь": 2},
	"Сталь":  {"Уголь": 1, "Железо": 1},
	"Стекло": {"Уголь": 1},
	"Ткань":  {"Хлопок":1},
	
	"Электрозапчасти": {
		"Железо":    1,
		"Резина":    1,
		"Стекло":    1,
	},
	"Автозапчасти":    {
		"Сталь":     1,
	},
	"Удобрения":       {
		"Уголь":     1,
	},
	"Пиломатериалы":   {
		"Древесина": 1,
	},
	"Динамит":         {
		"Селитра":   1,
	},
	"Автомобили":      {
		"Резина":    1,
		"Сталь":     2,
		"Стекло":    1,
		"Автозапчасти":       1,
		"Электрозапчасти":    1,
	},
	"Тракторы":        {
		"Резина":   1,
		"Сталь":    2,
		"Автозапчасти":        2,
	},
	"Телеграфы":       {
		"Железо":    1,
		"Электрозапчасти":     1,
	},
	"Телефоны":        {
		"Железо":    1,
		"Электрозапчасти":     1,
	},
	"Радио":           {
		"Железо":   1,
		"Стекло":   1,
		"Электрозапчасти":     1,
	},
	"Мебель":          {
		"Пиломатериалы":       1,
	},
	"Спиртное":        {
		"Уголь":    1,
		"Зерно":    1,
	},
	"Одежда":          {
		"Ткань":    1,
	},
	"Обогреватели":    {
		"Сталь":    2,
	},
	"Хлеб":            {
		"Зерно":    1,
	},
	"Консервы":        {
		"Железо":   1,
		"Зерно":    1,
		"Скот":     1,
	},
	"Топливо":         {
		"Нефть":    1,
	},
	
	"Лекарства":       {
		"Лекарственные_растения": 1,
	},
	
	"Снаряды":         {
		"Железо":   2,
		"Селитра":  2
	},
	"Боеприпасы":         {
		"Железо":  1,
		"Ткань":   1,
		"Селитра": 1,
		"Пиломатериалы": 1,
	},
	"Пулеметы":         {
		"Сталь":   2,
		"Автозапчасти":  2
	},
	"Артиллерия":         {
		"Сталь":   4,
		"Автозапчасти":  2
	},
	"Аэроплан":         {
		"Пиломатериалы":   4,
		"Автозапчасти":  3
	},
	"Магазинные_винтовки":         {
		"Сталь":   2,
		"Пиломатериалы":  2,
		"Автозапчасти":  1
	},
	"Бронемашины": {
		"Автомобили": 1,
		"Сталь":      2,
		"Пулеметы":   2,
		"Артиллерия": 1,
	},
	"Танки": {
		"Автомобили": 1,
		"Тракторы":   1,
		"Сталь":      6,
		"Пулеметы":   3,
		"Артиллерия": 1,
	},
}


const list_of_resourses: Array = [
	"Уголь",
	"Железо",
	"Нефть",
	"Резина",
	"Хлопок",
	"Зерно",
	"Скот",
	"Селитра",
	"Древесина",
	"Табак",
	"Лекарственные_растения",
	"Чай",
	"Кофе", 
	]


const bonuses_for_production_of_civilian_goods: Dictionary = {
	"Мебель":        2,
	"Спиртное":      2,
	"Одежда":        3,
	"Обогреватели":  3,
	"Хлеб":          6,
	"Консервы":      2,
	"Топливо":       2,
	"Лекарства":     2,
	"Пиломатериалы": 3,
}

func append_dictionary(players):
	for i in prices_of_goods:
		quanity_of_goods[i] = {}
		
		for player in players:
			quanity_of_goods[i][player] = 0
			

func find_building_in_list(name_of_building):
	for i in Players.goods_to_factory:
		if Players.goods_to_factory[i] == name_of_building:
			return i


func clear_supply_and_demand():
	for i in supply:
		supply[i] = 0
	for i in demand:
		if list_of_resourses.has(i) and bonuses_for_production_of_civilian_goods.has(i):
			demand[i] = 0
		else:
			demand[i] = 10


func clear_export_and_import():
	for player in Players.list_of_players:
		for good in player.export_of_goods:
			player.export_of_goods[good] = 0
			player.import_of_goods[good] = 0
		for good in player.output:
			player.output[good] = 0


func update_prices():
	for good in prices_of_goods:
		if demand[good] > supply[good]:
			prices_of_goods[good] += 1
		elif demand[good] <= supply[good]:
			prices_of_goods[good] -= 1
			
		if prices_of_goods[good] > min_and_max_prices_of_goods[good].max_:
			prices_of_goods[good] = min_and_max_prices_of_goods[good].max_
		elif prices_of_goods[good] < min_and_max_prices_of_goods[good].min_:
			prices_of_goods[good] = min_and_max_prices_of_goods[good].min_


func export_goods_from_local_markets():
	#{"Уголь": {player_1: 12, player_2: 3 ...},
	for player in Players.list_of_players:
		for good in player.local_market:
			quanity_of_goods[good][player] += player.local_market[good]
			player.export_of_goods[good] += player.local_market[good]
			GlobalMarket.supply[good] += player.local_market[good]
			player.local_market[good] = 0

