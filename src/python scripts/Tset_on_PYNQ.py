from pynq import Overlay 
from PIL import Image 


# connect network
platform = Overlay("design_1. bit")
neural_net = platform.m_neural_net_0


# Address for in and out ports
NEURAL_NET_IN_ADDR = 3 * 4
NEURAL_NET_IN_COUNT = 4 * 4
NEURAL_NET_OUT_ADDR = 5 * 4


# Prepear image
image = Image.open("pic3.png")
pixel_values = list (image.getdata())
width, height = image.size
pixel_values = [pixel_values[i * width: (i + 1) * width] 
                for i in range(height)]


# pixel counter for correct transfer of each pixels
pixel_count = 1

for i in range (height):
    for j in range(width):
        neural_net.write(NEURAL_NET_IN_COUNT, pixel_count) # send counter 
         # send pixel in Q12.12
        neural_net.write(NEURAL_NET_IN_ADDR, pixel_values[i][j] < 4)
        pixel_count = pixel_count + 1
        
        
output = neural_net.read(NEURAL_NET_OUT_ADDR) # read answer
print (output)