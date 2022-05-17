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
	
	"Сталь":     50,
	"Стекло":    50,
	"Ткань":     50,
	"Электрозапчасти": 50,
	"Автозапчасти":    50,
	"Удобрения":       50,
	"Пиломатериалы":   50,
	"Динамит":         50,
	
	"Автомобили":      45,
	"Тракторы":        45,
	"Телеграфы":       45,
	"Телефоны":        45,
	"Радио":           45,
	"Миксеры":         45,
	"Электропечи":     45,
	"Холодильники":    45,
	
	"Мебель":          45,
	"Спиртное":        45,
	"Одежда":          45,
	"Обогреватели":    45,
	"Хлеб":            15,
	"Консервы":        45,
	"Топливо":         45,
	"Табак":           45,
	
	"Снаряды":             45,
	"Боеприпасы":          45,
	"Пулеметы":            45,
	"Артиллерия":          45,
	"Аэропланы":           45,
	"Магазинные_винтовки": 45,
}

const min_and_max_prices_of_goods: Dictionary = {
	"Уголь":     {
		min_ = 15,
		max_ = 25
	},
	"Железо":    {
		min_ = 15,
		max_ = 25
	},
	"Нефть":     {
		min_ = 20,
		max_ = 30
	},
	"Резина":    {
		min_ = 15,
		max_ = 20
	},
	"Хлопок":    {
		min_ = 10,
		max_ = 15
	},
	"Зерно":     {
		min_ = 10,
		max_ = 15
	},
	"Скот":      {
		min_ = 10,
		max_ = 20
	},
	"Селитра":   {
		min_ = 20,
		max_ = 30
	},
	"Древесина": {
		min_ = 15,
		max_ = 25
	},
	
	"Сталь":     {
		min_ = 30,
		max_ = 40
	},
	"Стекло":    {
		min_ = 20,
		max_ = 30
	},
	"Ткань":     {
		min_ = 10,
		max_ = 20
	},
	"Электрозапчасти": {
		min_ = 60,
		max_ = 70
	},
	"Автозапчасти":    {
		min_ = 60,
		max_ = 70
	},
	"Удобрения":       {
		min_ = 20,
		max_ = 30
	},
	"Пиломатериалы":   {
		min_ = 10,
		max_ = 20
	},
	"Динамит":         {
		min_ = 20,
		max_ = 30
	},
	
	"Автомобили":      {
		min_ = 360,
		max_ = 400
	},
	"Тракторы":        {
		min_ = 290,
		max_ = 340
	},
	"Телеграфы":       {
		min_ = 80,
		max_ = 100
	},
	"Телефоны":        {
		min_ = 90,
		max_ = 110
	},
	"Радио":           {
		min_ = 110,
		max_ = 120
	},
	"Миксеры":         {
		min_ = 160,
		max_ = 170
	},
	"Электропечи":     {
		min_ = 150,
		max_ = 160
	},
	"Холодильники":    {
		min_ = 220,
		max_ = 240
	},
	
	"Мебель":          {
		min_ = 40,
		max_ = 60
	},
	"Спиртное":        {
		min_ = 25,
		max_ = 40
	},
	"Одежда":          {
		min_ = 25,
		max_ = 40
	},
	"Обогреватели":    {
		min_ = 80,
		max_ = 100
	},
	"Хлеб":            {
		min_ = 10,
		max_ = 20
	},
	"Консервы":        {
		min_ = 30,
		max_ = 40
	},
	"Топливо":         {
		min_ = 55,
		max_ = 70
	},
	"Табак":           {
		min_ = 15,
		max_ = 30
	},
	
	"Снаряды":             {
		min_ = 90,
		max_ = 110
	},
	"Боеприпасы":          {
		min_ = 80,
		max_ = 95
	},
	"Пулеметы":            {
		min_ = 230,
		max_ = 245
	},
	"Артиллерия":          {
		min_ = 320,
		max_ = 380
	},
	"Аэропланы":           {
		min_ = 280,
		max_ = 330
	},
	"Магазинные_винтовки": {
		min_ = 200,
		max_ = 250
	},
}

var demand: Dictionary = prices_of_goods.duplicate()
var supply: Dictionary = prices_of_goods.duplicate()

const min_price_of_good: Dictionary = {
	"Уголь":     20,
	"Железо":    20,
	"Нефть":     25,
	"Резина":    20,
	"Хлопок":    15,
	"Зерно":     10,
	"Скот":      10,
	"Селитра":   20,
	"Древесина": 15,
	"Табак":     15,
}

const goods: Dictionary = {
	"Резина":    {
		"Уголь": 2,
	},
	"Сталь":     {
		"Уголь": 1,
		"Железо": 1,
	},
	"Стекло":    {
		"Уголь":     1,
	},
	"Ткань":     {
		"Хлопок":    1,
	},
	"Электрозапчасти": {
		"Железо":    1,
		"Резина":    1,
		"Стекло":    1,
	},
	"Автозапчасти":    {
		"Железо":    1,
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
		"Резина":    2,
		"Сталь":     2,
		"Стекло":    1,
		"Автозапчасти":       2,
		"Электрозапчасти":    1,
	},
	"Тракторы":        {
		"Резина":   1,
		"Сталь":    3,
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
	"Миксеры":         {
		"Железо":   1,
		"Электрозапчасти":   1,
		"Автозапчасти":      1,
	},
	"Электропечи":     {
		"Сталь":   3,
		"Стекло":   1,
	},
	"Холодильники":    {
		"Сталь":   3,
		"Стекло":   1,
		"Электрозапчасти":     1,
	},
	"Мебель":          {
		"Пиломатериалы":       2,
		"Железо":   1,
	},
	"Спиртное":        {
		"Уголь":    1,
		"Зерно":    1,
	},
	"Одежда":          {
		"Ткань":    2,
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
		"Нефть":    2,
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
	"Аэропланы":         {
		"Пиломатериалы":   4,
		"Автозапчасти":  3
	},
	"Магазинные_винтовки":         {
		"Сталь":   2,
		"Пиломатериалы":  2,
		"Автозапчасти":  1
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
	]

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
		if list_of_resourses.has(i):
			demand[i] = 0
		else:
			demand[i] = 5


func clear_export_and_import():
	for player in Players.list_of_players:
		for good in player.export_of_goods:
			player.export_of_goods[good] = 0
			player.import_of_goods[good] = 0


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

