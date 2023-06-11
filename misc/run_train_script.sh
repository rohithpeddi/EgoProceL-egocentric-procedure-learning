#!/bin/bash

commands=(
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_blender_banana_pancakes.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_breakfast_burritos.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_broccoli_stir_fry.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_butter_corn_cup.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_caprese_bruschetta.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_cheese_pimiento.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_coffee.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_cucumber_raita.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_default.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_dressed_up_meatballs.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_herb_omelet_with_fried_tomatoes.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_microwave_egg_sandwich.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_microwave_french_toast.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_microwave_mug_pizza.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_mug_cake.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_pan_fried_tofu.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_pinwheels.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_ramen.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_sauted_mushrooms.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_scrambled_eggs.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_spiced_hot_chocolate.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_spicy_tuna_avocado_wraps.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_tomato_chutney.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_tomato_mozzarella_salad.yaml &"
    "nohup python -m RepLearn.TCC.main --cfg configs/egoerror_config_zoodles.yaml &"
)

step_size=5  # Number of commands to execute in each step
interval=180  # 3 minutes
sleep_time=$((3 * 60 * 60))  # 3 hours in seconds

total_commands=${#commands[@]}
total_steps=$(( (total_commands + step_size - 1) / step_size ))

for ((step=0; step<total_steps; step++)); do
    start=$((step * step_size))
    end=$(( (start + step_size) < total_commands ? (start + step_size) : total_commands ))
    
    echo "Step $((step+1)): Running commands $start to $((end-1))"
    
    for ((i=start; i<end; i++)); do
        cmd="${commands[$i]}"
        echo "Running command: $cmd"
        eval "$cmd"
        sleep "$interval"
    done
    
    if (( step < (total_steps - 1) )); then
        echo "Waiting for 3 hours..."
        sleep "$sleep_time"
    fi
done
