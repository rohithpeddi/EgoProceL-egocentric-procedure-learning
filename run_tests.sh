#!/bin/bash

# List of commands
commands=(
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_blender_banana_pancakes.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_breakfast_burritos.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_broccoli_stir_fry.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_butter_corn_cup.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_caprese_bruschetta.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_cheese_pimiento.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_coffee.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_cucumber_raita.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_default.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_dressed_up_meatballs.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_herb_omelet_with_fried_tomatoes.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_microwave_egg_sandwich.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_microwave_french_toast.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_microwave_mug_pizza.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_mug_cake.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_pan_fried_tofu.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_pinwheels.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_ramen.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_sauted_mushrooms.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_scrambled_eggs.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_spiced_hot_chocolate.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_spicy_tuna_avocado_wraps.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_tomato_chutney.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_tomato_mozzarella_salad.yaml"
    "python -m RepLearn.TCC.procedure_learning --cfg configs/egoerror_config_zoodles.yaml"
)

# Function to run commands
run_commands() {
    for command in "${commands[@]}"; do
        # Run commands in background
        echo "Running command: $command"
        eval "$command" &

        # Limit the number of concurrent processes to 3
        if (( $(jobs -r -p | wc -l) >= 3 )); then
            wait -n
        fi
    done

    # Wait for all background processes to finish
    wait
}

# Execute the function to run commands
run_commands