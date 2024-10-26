import numpy as np
import torch
import torch.nn as nn
import os


def to_fixed_point(value, integer_bits, fraction_bits):
    '''Converts a value into fixed-point format.'''
    
    scale = 2 ** fraction_bits  
    fixed_value = int(np.round(value * scale)) # Convert to fixed-point
    
    return fixed_value 

def to_hex_string(value, total_bits):
    '''Converts a fixed-point number into a hex string.'''
    # Mask the number to fit within total bits and removes the "0x" prefix
    hex_value = hex(value & ((1 << total_bits) - 1))[2:]  
    hex_digits = (total_bits + 3) // 4  
    return hex_value.zfill(hex_digits)  # Pad with leading zeros if necessary

def load_model(model_path):
    '''Load model.''' 
    
    model = nn.Sequential(
        nn.Linear(784, 10),  
        nn.Softmax(dim=1)
    )
    model.load_state_dict(torch.load(model_path))
    model.eval()
    
    return model

def save_weights(model_path, integer_bits, fraction_bits):
    '''Conver weights to hex fixed-point and save to mem file.'''
    
    model = load_model(model_path)
    weights = model[0].weight.data.numpy() # Extract weights from the model
    total_bits = integer_bits + fraction_bits  
    
    hex_weights = []

    for i, row in enumerate(weights):
        hex_row = []
        for w in row:
            fixed_point_value = to_fixed_point(w, integer_bits, fraction_bits)  
            hex_value = to_hex_string(fixed_point_value, total_bits) 
            hex_row.append(hex_value)
        
        hex_weights.append(hex_row)

        # Write each row of weights to a separate .mem file
        
        path = f"ROM_files\mem\\format_q{integer_bits}_{fraction_bits}\\"
        if not os.path.exists(path):
            os.makedirs(path)
        filename = path + f'weight_q{integer_bits}_{fraction_bits}_N{i}.mem'
        with open(filename, 'w') as f:
            for hex_value in hex_row:
                f.write(f"{hex_value}\n")


# Model path and bits number
model_path = 'epoh_10000_data_10000.pth'
integer_bits = 6  
# fraction_bits = 16  

fraction_bits = range(1,16)
for f_bits in fraction_bits:
    save_weights(model_path, integer_bits, f_bits)