import pandas as pd
from sklearn.linear_model import LinearRegression

# Load the training data into a pandas DataFrame
data = pd.read_csv('training_data.csv')

# Separate the input variables (X) from the output variable to be minimized (y)
X = data.iloc[:, :-1]
y = data.iloc[:, -1]

# Train a linear regression model on the training data
model = LinearRegression().fit(X, y)

# Print the coefficients of the linear regression model, which represent the values of the input parameters
print(model.coef_)