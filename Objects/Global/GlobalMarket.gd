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
	
	"Автомобили":      45,
	"Тракторы":        45,
	"Телеграфы":       45,
	"Телефоны":        45,
	"Радио":           45,
	
	"Мебель":          45,
	"Спиртное":        45,
	"Одежда":          45,
	"Обогреватели":    45,
	"Хлеб":            15,
	"Консервы":        45,
	"Топливо":         45,
	"Табак":           45,
	"Лекарства":       10,
	
	"Снаряды":             45,
	"Боеприпасы":          45,
	"Пулеметы":            45,
	"Артиллерия":          45,
	"Аэроплан":            45,
	"Магазинные_винтовки": 45,
}

const min_and_max_prices_of_goods: Dictionary = {
	"Уголь":     {min_ = 15, max_ = 30},
	"Железо":    {min_ = 15, max_ = 30},
	"Нефть":     {min_ = 20, max_ = 30},
	"Резина":    {min_ = 20, max_ = 30},
	"Хлопок":    {min_ = 15, max_ = 30},
	"Зерно":     {min_ = 10, max_ = 20},
	"Скот":      {min_ = 10, max_ = 20},
	"Селитра":   {min_ = 15, max_ = 30},
	"Древесина": {min_ = 15, max_ = 30},
	"Лекарственные_растения": {min_ = 10, max_ = 30},
	
	"Сталь":                  {min_ = 30, max_ = 40},
	"Стекло":                 {min_ = 20, max_ = 40},
	"Ткань":                  {min_ = 10, max_ = 40},
	"Электрозапчасти":        {min_ = 60, max_ = 80},
	"Автозапчасти":           {min_ = 60, max_ = 80},
	"Удобрения":              {min_ = 20, max_ = 40},
	"Пиломатериалы":          {min_ = 10, max_ = 40},
	"Динамит":                {min_ = 20, max_ = 40},
	
	"Автомобили":             {min_ = 360,max_ = 400},
	"Тракторы":               {min_ = 290,max_ = 400},
	"Телеграфы":              {min_ = 80, max_ = 150},
	"Телефоны":               {min_ = 90, max_ = 150},
	"Радио":                  {min_ = 110,max_ = 150},
	
	"Мебель":          {min_ = 40, max_ = 60},
	"Спиртное":        {min_ = 30, max_ = 60},
	"Одежда":          {min_ = 30, max_ = 60},
	"Обогреватели":    {min_ = 50, max_ = 100},
	"Хлеб":            {min_ = 10, max_ = 40},
	"Консервы":        {min_ = 40, max_ = 60},
	"Топливо":         {min_ = 50, max_ = 60},
	"Табак":           {min_ = 10, max_ = 40},
	"Лекарства":       {min_ = 10, max_ = 40},    
	
	   "Снаряды":             {min_ = 90, max_ = 110},
	   "Боеприпасы":          {min_ = 80, max_ = 100},
	   "Пулеметы":            {min_ = 200,max_ = 250},
	   "Артиллерия":          {min_ = 300,max_ = 350},
	   "Аэроплан":           {min_ = 250,max_ = 300},
	   "Магазинные_винтовки": {min_ = 80, max_ = 110},
}

var demand: Dictionary = prices_of_goods.duplicate()
var supply: Dictionary = prices_of_goods.duplicate()

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
		"Сталь":     3,
		"Стекло":    1,
		"Автозапчасти":       1,
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
	"Мебель":          {
		"Пиломатериалы":       2,
		"Железо":   1,
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

