extends Resource


export(String, "liberals", "libertarians", "socialists", "communists", "fascists", "conservators") var ideology = "liberals"

export(Resource) var economic_policy = Resource
export(Resource) var trade_policy = Resource
export(Resource) var foreign_policy = Resource

export(Array) var names_of_parties = []

export(int) var supporting_soc_reforms = 0
export(int) var supporting_pol_reforms = 0

export(Resource) var form_of_government = Resource

