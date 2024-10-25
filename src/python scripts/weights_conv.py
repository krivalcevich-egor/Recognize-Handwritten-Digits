import numpy as np

def read_weights(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Print the entire content to inspect it
    print("File content:\n", content)
    
    # Split content into lines and check each line
    lines = content.splitlines()
    numerical_lines = []
    
    for line in lines:
        try:
            # Try converting the line to a float
            float(line)
            numerical_lines.append(line)
        except ValueError:
            print(f"Non-numerical line ignored: {line}")
    
    # Convert filtered lines to numpy array of floats
    weights = np.array(numerical_lines, dtype=float)
    return weights

# Usage example
file_path = 'weights.txt'
weights = read_weights(file_path)
print("Weights:", weights)
