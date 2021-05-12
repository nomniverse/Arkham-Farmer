extends Node


enum {
	NONE,
	CORN,
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
}


func id_to_name(crop_id):
	return Crops.keys()[crop_id]


func get_crop_by_seed(seed_id):
	for key in crop_properties.keys():
		if crop_properties[key]['seed'] == seed_id:
			return key
