extends Node

const tipe = "factory"

const time:              int          = 3
var money:               int          = 500#100
var income:              int          = 0
var max_employed_number: int          = 1
var reserve:             int          = 0
var subsidization:       bool         = false
var closed:              bool         = false
var good:            String           = ""
var name_of_factory: String           = ""
var purchase:    Dictionary           = {}

var list_of_workers: Array = []

var province:         Object
#var object_of_worker: Object
var expansion:        Object
