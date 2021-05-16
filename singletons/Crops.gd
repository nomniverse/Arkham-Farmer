extends Node


enum {
	NONE,
	CORN,
	TOMATO,
	CUCUMBER,
	PEPPER,
	BROCCOLI,
	CARROT,
	POTATO,
}


var crop_properties = {
	NONE: {
		'seed': Items.NO_ITEM,
		'fruit': Items.NO_ITEM,
	},
	CORN: {
		'seed': Items.CORN_SEEDS,
		'fruit': Items.CORN,
	},
	TOMATO: {
		'seed': Items.TOMATO_SEEDS,
		'fruit': Items.TOMATO,
	},
	CUCUMBER: {
		'seed': Items.CUCUMBER_SEEDS,
		'fruit': Items.CUCUMBER,
	},
	PEPPER: {
		'seed': Items.PEPPER_SEEDS,
		'fruit': Items.PEPPER,
	},
	BROCCOLI: {
		'seed': Items.BROCCOLI_SEEDS,
		'fruit': Items.BROCCOLI,
	},
	CARROT: {
		'seed': Items.CARROT_SEEDS,
		'fruit': Items.CARROT,
	},
	POTATO: {
		'seed': Items.POTATO_SEEDS,
		'fruit': Items.POTATO,
	},
}


func id_to_name(crop_id):
	return Crops.keys()[crop_id]


func get_crop_by_seed(seed_id):
	for key in crop_properties.keys():
		if crop_properties[key]['seed'] == seed_id:
			return key
