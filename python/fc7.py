import pandas as pd

file_path = 'Mg4.4Fc.txt'

data = pd.read_csv(file_path, sep='\t', header=None, engine='python')

data[2] = pd.to_numeric(data[2], errors='cerce')
filtered = data[data[2].notnull() & (data[2] >= 7)]

print(filtered)

