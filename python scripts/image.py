from PIL import Image
import numpy as np

def process_image(image_path):
    img = Image.open(image_path).convert('L') 
    img_array = np.array(img)
    
    normalized_img_array = img_array / 255.0
    
    processed_img_array = np.floor(normalized_img_array * 4096).astype(int)
    
    height, width = processed_img_array.shape
    pixel_variables = {}
    for y in range(height):
        for x in range(width):
            pixel_variables[f'pixel_{y}_{x}'] = processed_img_array[y, x]
    
    return pixel_variables

image_path = 'pic5.png'
pixel_variables = process_image(image_path)

for key in list(pixel_variables.keys())[:784]:
    print(f'{pixel_variables[key]}')
