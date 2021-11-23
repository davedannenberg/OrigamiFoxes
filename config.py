# CONFIG is an array of objects where each object represents a layer in an NFT picture.

# All input images should be in an 'assets' folder, and MUST be ordered.
# Each layer (or category) of images must be put in a folder of its own.
# Each layer needs to specify the following
# 1. id: A number representing a particular layer
# 2. name: The name of the layer. Does not necessarily have to be the same as the directory name containing the layer images.
# 3. directory: The folder inside assets that contain traits for the particular layer
# 4. required: If the particular layer is required (True) or optional (False). The first layer must always be set to true.
# 5. rarity_weights: Denotes the rarity distribution of traits. We use an array of numbers where each number represents a weight. 

CONFIG = [
    {   'id': 1, 
        'name': 'ear_traits', 
        'directory': 'Ears', 
        'required': True, 
        'rarity_weights': [20, 20, 20, 20, 20]},

    {   'id': 2, 
        'name': 'face_tail_traits', 
        'directory': 'FaceTail', 
        'required': True, 
        'rarity_weights': [22, 22, 22, 22, 12]},  

    {   'id': 3, 
        'name': 'lower_body_traits', 
        'directory': 'LowerBody', 
        'required': True, 
        'rarity_weights': [18, 18, 18, 18, 18, 10]}, 

    {   'id': 4, 
        'name': 'upper_body_traits', 
        'directory': 'UpperBody', 
        'required': True, 
        'rarity_weights': [5, 5, 5, 5, 16, 16, 16, 16, 16]}, 
]
