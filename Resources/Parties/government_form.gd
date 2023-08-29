extends Resource

class_name GovernmentForm

@export var policy_name: String = ""

@export var elections: bool = false #Если выборов нет, то в Парламенте будет присутсвовать только прав. партия

@export var reforms_after_revolution = [] # (Array, Resource)
