import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# Provided data
years_provided = np.arange(1973, 2022)
spending_provided = np.array([
    0.68, 0.69, 0.70, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77,
    0.78, 0.79, 0.80, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87,
    0.88, 0.90, 0.92, 0.94, 0.96, 1.00, 1.03, 1.09, 1.14, 1.21,
    1.28, 1.34, 1.39, 1.42, 1.47, 1.54, 1.57, 1.62, 1.63, 1.62,
    1.63, 1.64, 1.66, 1.69, 1.74, 1.82, 1.91, 1.92, 1.98
])

# Calculate the average annual percentage increase
total_years = years_provided[-1] - years_provided[0]
percentage_increase = ((spending_provided[-1] / spending_provided[0]) - 1) * 100
average_annual_percentage_increase = percentage_increase / total_years

# Fitting a simple linear regression model to the provided data
def linear_model(x, a, b):
    return a * x + b

params, _ = curve_fit(linear_model, years_provided, spending_provided)

# Projecting over 500 years
years_projected = np.arange(1973, 1973 + 500)
spending_projected = linear_model(years_projected, *params)

# Calculate the spending for 2023 using the linear model
spending_2023 = linear_model(2023, *params)

# Calculate reduced spending for each year, starting from 2023's spending
reduced_spending = [spending_2023]
for year in range(1, 500):
    reduced_spending.append(reduced_spending[-1] * 0.99)  # Reduce to 99% of the previous year

# Adjust the years_projected for the reduced spending to start at 2023
years_reduced_spending = np.arange(2023, 2023 + 500)

# Plotting
plt.figure(figsize=(14, 8))
plt.plot(years_provided, spending_provided, 'bo', label='Historical Data')
plt.plot(years_projected, spending_projected, 'r-', label='Projected Status Quo')
plt.plot(years_reduced_spending, reduced_spending, 'g--', label='Reduced Spending Scenario (99% per year)')

plt.xlabel('Year')
plt.ylabel('Global Military Spending (Trillions USD)')
plt.title('Historical and Projected Global Military Spending Over 500 Years')

# Display the average annual percentage increase on the chart
plt.text(2000, 2, f'Avg Annual % Increase: {average_annual_percentage_increase:.2f}%', fontsize=12)

plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()