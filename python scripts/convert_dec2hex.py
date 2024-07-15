import os

# Function to convert a decimal number to 24-bit hex
def dec_to_hex_24bit(dec):
    # Convert decimal to int
    dec = int(dec)
    # Handle negative values by converting to 2's complement for 24-bit
    if dec < 0:
        dec = (1 << 24) + dec
    # Convert to hex and remove '0x' prefix
    hex_str = f'{dec:06X}'
    return hex_str

# Read the input file
input_file = 'weights.txt'
output_dir = 'output_hex_files'

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

with open(input_file, 'r') as file:
    lines = file.readlines()
    for i, line in enumerate(lines):
        numbers = line.split()
        hex_numbers = [dec_to_hex_24bit(num) for num in numbers]
        output_file = os.path.join(output_dir, f'wweight_{i}.mem')
        with open(output_file, 'w') as out_file:
            for hex_num in hex_numbers:
                out_file.write(hex_num + '\n')

print("Conversion complete. Check the output_hex_files directory.")
