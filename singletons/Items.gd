extends Node

enum {
	NO_ITEM,
	WATER_CAN,
	PICKAXE,
	AXE,
	HOE,
	LOG,
	CORN_SEEDS,
	CORN,
	TOMATO_SEEDS,
	TOMATO,
	CUCUMBER_SEEDS,
	CUCUMBER,
	PEPPER_SEEDS,
	PEPPER,
	BROCCOLI_SEEDS,
	BROCCOLI,
	CARROT_SEEDS,
	CARROT,
	POTATO_SEEDS,
	POTATO,
	EGG,
	APPLE,
	ORANGE,
	PEAR,
	PEACH,
	CHERRY,
	REVOLVER,
	BULLET,
	FENCE,
	BOX,
	RAW_STONE,
	MINED_STONE,
}

enum ItemType {
	NULL,
	BLOCK,
	CONTAINER,
	ITEM,
	TOOL,
	RANGED_WEAPON,
	AMMO,
	MELEE_WEAPON,
	SEED,
	FOOD,
	ROCK,
	ORE,
}

var TRANSPARENT_TEXTURE_PATH = preload("res://assets/transparent_tile.png")
var ANIMALS_TEXTURE_PATH = preload("res://assets/Farming and Mining/Animals.png")
var CITIZENS_TEXTURE_PATH = preload("res://assets/Farming and Mining/Citizens.png")
var CLOTHING_TEXTURE_PATH = preload("res://assets/Farming and Mining/ClothingArmor.png")
var ENVIRONMENT_TEXTURE_PATH = preload("res://assets/Farming and Mining/Environment.png")
var FENCE_TEXTURE_PATH = preload("res://assets/Farming and Mining/Fence.png")
var FRUITS_VEG_SEED_TEXTURE_PATH = preload("res://assets/Farming and Mining/FruitsVegSeed.png")
var FURNITURE_TEXTURE_PATH = preload("res://assets/Farming and Mining/Furniture.png")
var HAIR_TEXTURE_PATH = preload("res://assets/Farming and Mining/Hair.png")
var MINERALS_TEXTURE_PATH = preload("res://assets/Farming and Mining/Minerals.png")
var REFINED_MATERIALS_TEXTURE_PATH = preload("res://assets/Farming and Mining/RefinedMaterials.png")
var THOUGHT_BUBBLE_TEXTURE_PATH = preload("res://assets/Farming and Mining/ThoughtBubbles.png")
var TOOLS_TEXTURE_PATH = preload("res://assets/Farming and Mining/Tools.png")


var item_properties = {
	NO_ITEM: {
		"name": "",
		"texture_file": TRANSPARENT_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.NULL,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	WATER_CAN: {
		"name": "Watering Can",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 288, 32, 32),
		"item_type": ItemType.TOOL,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	PICKAXE: {
		"name": "Pickaxe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.TOOL,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	AXE: {
		"name": "Axe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 32, 32, 32),
		"item_type": ItemType.TOOL,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	HOE: {
		"name": "Hoe",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 64, 32, 32),
		"item_type": ItemType.TOOL,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	LOG: {
		"name": "Log",
		"texture_file": ENVIRONMENT_TEXTURE_PATH,
		"icon": Rect2(352, 32, 32, 32),
		"item_type": ItemType.BLOCK,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CORN_SEEDS: {
		"name": "Corn Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(160, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CORN: {
		"name": "Corn",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(32, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	TOMATO_SEEDS: {
		"name": "Tomato Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(0, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	TOMATO: {
		"name": "Tomato",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(0, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CUCUMBER_SEEDS: {
		"name": "Cucumber Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(160, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CUCUMBER: {
		"name": "Cucumber",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(64, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	PEPPER_SEEDS: {
		"name": "Pepper Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(256, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	PEPPER: {
		"name": "Pepper",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(96, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	BROCCOLI_SEEDS: {
		"name": "Broccoli Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(192, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	BROCCOLI: {
		"name": "Broccoli",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(128, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CARROT_SEEDS: {
		"name": "Carrot Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(224, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CARROT: {
		"name": "Carrot",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(160, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	POTATO_SEEDS: {
		"name": "Potato Seeds",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(288, 224, 32, 32),
		"item_type": ItemType.SEED,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	POTATO: {
		"name": "Potato",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(192, 64, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	EGG: {
		"name": "Egg",
		"texture_file": ANIMALS_TEXTURE_PATH,
		"icon": Rect2(224, 64, 32, 32),
		"item_type": ItemType.ITEM,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	APPLE: {
		"name": "Apple",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"small_icon": Rect2(0, 32, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	ORANGE: {
		"name": "Orange",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(32, 0, 32, 32),
		"small_icon": Rect2(32, 32, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	PEAR: {
		"name": "Pear",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(64, 0, 32, 32),
		"small_icon": Rect2(64, 32, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	PEACH: {
		"name": "Peach",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(96, 0, 32, 32),
		"small_icon": Rect2(96, 32, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	CHERRY: {
		"name": "Cherry",
		"texture_file": FRUITS_VEG_SEED_TEXTURE_PATH,
		"icon": Rect2(160, 0, 32, 32),
		"small_icon": Rect2(160, 32, 32, 32),
		"item_type": ItemType.FOOD,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	REVOLVER: {
		"name": "Revolver",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 320, 32, 32),
		"item_type": ItemType.RANGED_WEAPON,
		"capacity": 6,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	BULLET: {
		"name": "Bullet",
		"texture_file": TOOLS_TEXTURE_PATH,
		"icon": Rect2(0, 352, 32, 32),
		"item_type": ItemType.AMMO,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	FENCE: {
		"name": "Fence",
		"texture_file": FENCE_TEXTURE_PATH,
		"icon": Rect2(0, 96, 32, 32),
		"item_type": ItemType.BLOCK,
		"recipe": {
			"ingredients": {
				LOG: 3
			},
			"time": 0
		}
	},
	BOX: {
		"name": "Box",
		"texture_file": FURNITURE_TEXTURE_PATH,
		"icon": Rect2(0, 0, 32, 32),
		"item_type": ItemType.CONTAINER,
		"empty_icon": Rect2(32, 0, 32, 32),
		"recipe": {
			"ingredients": {
				LOG: 3
			},
			"time": 0
		}
	},
	RAW_STONE: {
		"name": "Raw Stone",
		"texture_file": MINERALS_TEXTURE_PATH,
		"icon": [
			Rect2(0, 0, 32, 32),
			Rect2(32, 0, 32, 32),
			Rect2(64, 0, 32, 32),
		],
		"item_type": ItemType.ROCK,
		"drop": MINED_STONE,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
	MINED_STONE: {
		"name": "Mined Stone",
		"texture_file": MINERALS_TEXTURE_PATH,
		"icon": Rect2(0, 64, 32, 32),
		"item_type": ItemType.ORE,
		"recipe": {
			"ingredients": {},
			"time": 0
		}
	},
}


func get_items_of_type(type):
	var items = []
	
	for item in Items.keys():
		if item_properties[item]['item_type'] == type:
			items.append(item)
	
	return items
