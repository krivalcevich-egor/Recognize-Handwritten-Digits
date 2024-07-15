import numpy as np
import torch
import torchvision
import matplotlib.pyplot as plt
from torchvision import datasets, transforms
from torch import nn
from PIL import Image

def view_classify(img, ps, save_path=None):
    ''' Function for viewing an image and its predicted classes. '''
    ps = ps.data.numpy().squeeze()
    fig, (ax1, ax2) = plt.subplots(figsize=(6, 9), ncols=2)
    ax1.imshow(img.numpy().squeeze(), cmap='gray')
    ax1.axis('off')
    ax2.barh(np.arange(10), ps)
    ax2.set_aspect(0.1)
    ax2.set_yticks(np.arange(10))
    ax2.set_yticklabels(np.arange(10))
    ax2.set_title('Class Probability')
    ax2.set_xlim(0, 1.1)
    plt.tight_layout()
    if save_path:
        plt.savefig(save_path)
    plt.show()

# Transform image to tensor and normalize colors
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,))
])

# Download dataset
valset = datasets.MNIST('PATH_TO_STORE_TESTSET', download=True, train=False, transform=transform)
valloader = torch.utils.data.DataLoader(valset, batch_size=10000, shuffle=True)

# Define the model architecture (must be the same as in train.py)
input_size = 784
output_size = 10

model = nn.Sequential(
    nn.Linear(input_size, output_size),
    nn.Softmax(dim=1)
)

# Load the trained model
model.load_state_dict(torch.load('epoh_10000_data_10000.pth'))
model.eval()

# Save weights 
filename = 'weights_epoh_10000_data_10000.txt'
print("Model weights:")
with open(filename, 'w') as file_object:
    for name, param in model.state_dict().items():
        print(name, param)
        if 'weight' in name:
            file_object.write(f'{param.numpy().tolist()}\n')

# Evaluate with one image
images, labels = next(iter(valloader))
img = images[0].view(1, 784)

with torch.no_grad():
    logps = model(img)

ps = logps
probab = list(ps.numpy()[0])
print(f"Predicted Digit = {probab.index(max(probab))}")

# Save the image
img_to_save = Image.fromarray(images[0].numpy().squeeze() * 255).convert('L')
img_to_save.save('saved_image.png')

# View and classify the image
view_classify(images[0], ps, save_path='classified_image.png')

# Test the model on the validation set
correct_count, all_count = 0, 0
for images, labels in valloader:
    for i in range(len(labels)):
        img = images[i].view(1, 784)
        with torch.no_grad():
            logps = model(img)

        ps = logps  # Since we're using softmax in the model, no need for torch.exp
        probab = list(ps.numpy()[0])
        pred_label = probab.index(max(probab))
        true_label = labels.numpy()[i]
        if true_label == pred_label:
            correct_count += 1
        all_count += 1

print(f"Number Of Images Tested = {all_count}")
print(f"\nModel Accuracy = {correct_count/all_count}")
