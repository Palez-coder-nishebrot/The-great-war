extends Resource

class_name SavedFactory

export(int) var time_of_construction = 0
export(int) var income               = 0
export(int) var expenses_workers     = 0
export(int) var expenses_purchase    = 0
export(int) var expenses_mechanisms  = 0
export(int) var max_employed_number  = 2
export(float) var quantity_of_workers = 0.0

export(bool) var subsidization        = false
export(bool) var closed               = false
export(bool) var in_construction      = false


export(String) var name_of_factory = ""
export(String) var good = ""
export(int) var money = 500

export(Resource) var expansion
