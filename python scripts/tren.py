import numpy as np
import torch
import torchvision
import matplotlib.pyplot as plt
from time import time
from torchvision import datasets, transforms
from torch import nn, optim

# Transform image to 1x784 and normalize colors
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5,), (0.5,))
])

# Download dataset
trainset = datasets.MNIST('PATH_TO_STORE_TRAINSET', download=True, train=True, transform=transform)
valset = datasets.MNIST('PATH_TO_STORE_TESTSET', download=True, train=False, transform=transform)

# Create dataloaders
trainloader = torch.utils.data.DataLoader(trainset, batch_size=100, shuffle=True)
valloader = torch.utils.data.DataLoader(valset, batch_size=100, shuffle=True)

dataiter = iter(trainloader)
images, labels = next(dataiter)

print(images.shape)  # Output shape: [1000, 1, 28, 28]
print(labels.shape)  # Output shape: [1000]

# Build the Neural Network
input_size = 784  # 28x28 images flattened
output_size = 10  # 10 classes for digits 0-9

model = nn.Sequential(
    nn.Linear(input_size, output_size),
    nn.Softmax(dim=1)
)
print(model)

criterion = nn.CrossEntropyLoss()  # Use CrossEntropyLoss which includes softmax
optimizer = optim.SGD(model.parameters(), lr=0.003, momentum=0.9)

# Track MSE
mse_list = []

# Training the network
epochs = 10
time0 = time()

for e in range(epochs):
    running_loss = 0
    mse_loss = 0
    for images, labels in trainloader:
        # Flatten MNIST images into a 784 long vector
        images = images.view(images.shape[0], -1)
    
        # Training pass
        optimizer.zero_grad()
        
        output = model(images)
        loss = criterion(output, labels)
        
        # Calculate MSE
        mse_loss += torch.mean((output - nn.functional.one_hot(labels, num_classes=10).float())**2).item()
        
        # This is where the model learns by backpropagating
        loss.backward()
        
        # And optimizes its weights here
        optimizer.step()
        
        running_loss += loss.item()
    
    mse_list.append(mse_loss / len(trainloader))
    print(f"Epoch {e+1} - Training loss: {running_loss/len(trainloader)}")
    
print(f"\nTraining Time (in minutes) = {(time()-time0)/60}")

# Save the model
torch.save(model.state_dict(), 'epoh_10_data_100.pth')

# Plot MSE
plt.figure(figsize=(10, 5))
plt.plot(range(1, epochs + 1), mse_list, label='MSE')
plt.xlabel('Epochs')
plt.ylabel('MSE')
plt.title('Mean Squared Error During Training')
plt.legend()
plt.show()
