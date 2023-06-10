import os.path

import yaml

recipes_id_name_dict = {
    1: "Microwave Egg Sandwich",
    2: "Dressed Up Meatballs",
    3: "Microwave Mug Pizza",
    4: "Ramen",
    5: "Coffee",
    7: "Breakfast Burritos",
    8: "Spiced Hot Chocolate",
    9: "Microwave French Toast",
    10: "Pinwheels",
    12: "Tomato Mozzarella Salad",
    13: "Butter Corn Cup",
    15: "Tomato Chutney",
    16: "Scrambled Eggs",
    17: "Cucumber Raita",
    18: "Zoodles",
    20: "Sauted Mushrooms",
    21: "Blender Banana Pancakes",
    22: "Herb Omelet with Fried Tomatoes",
    23: "Broccoli Stir Fry",
    25: "Pan Fried Tofu",
    26: "Mug Cake",
    27: "Cheese Pimiento",
    28: "Spicy Tuna Avocado Wraps",
    29: "Caprese Bruschetta",
}
recipe_name_id_dict = {v: k for k, v in recipes_id_name_dict.items()}

recipe_names = recipes_id_name_dict.values()


def update_yaml_file(recipe_name):
    recipe_name_ = recipe_name.replace(" ", "_").lower()
    recipe_name_folder = recipe_name.replace(" ", "")
    with open('egoerror_config_default.yaml', 'r') as file:
        data = yaml.safe_load(file)

    root_folder = "/data/egoproceldata"
    recipe_data_path = os.path.join(root_folder, recipe_name_folder)
    recipe_logs_folder = os.path.join(recipe_data_path, "logs")
    recipe_videos_folder = os.path.join(recipe_data_path, "videos")
    recipe_annotations_folder = os.path.join(recipe_data_path, "annotations")

    data['LOG']['DIR'] = recipe_logs_folder

    data['LAV']['USE_CIDM'] = True
    data['LAV']['CONTRIB_PERCENT'] = 0.3

    data['ANNOTATION']['CATEGORY'] = os.path.join(recipe_videos_folder, "normal")
    data['TCC']['DATA_PATH'] = os.path.join(recipe_videos_folder, "normal")

    data['EGO_ERROR']['ANNS_PATH'] = os.path.join(recipe_annotations_folder, "normal")
    data['EGO_ERROR']['FRAMES_PATH'] = os.path.join(recipe_data_path, 'frames')
    data['EGO_ERROR']['VIDEOS_PATH'] = os.path.join(recipe_videos_folder, 'normal')

    if os.path.exists(recipe_logs_folder):
        # Parse the logs folder to get the last checkpoint or checkpoint with the lowest loss
        ckpt_logs_folder = recipe_logs_folder
        ckpt_names = [f for f in os.listdir(ckpt_logs_folder) if f.endswith('.pt')]

        # Extract the loss value from the file names and sort the list based on the loss
        sorted_files = sorted(ckpt_names, key=lambda x: float(x.split('_loss-')[1].split('.pt')[0]))

        # Get the checkpoint file with the lowest loss
        lowest_loss_checkpoint = sorted_files[0]
        print("Checkpoint file with the lowest loss:", lowest_loss_checkpoint)
        data['TCC']['MODEL_PATH'] = os.path.join(ckpt_logs_folder, lowest_loss_checkpoint)

    with open(f'egoerror_config_{recipe_name_}.yaml', 'w') as file:
        yaml.dump(data, file)


for recipe_name in recipe_names:
    print(recipe_name)
    update_yaml_file(recipe_name)
