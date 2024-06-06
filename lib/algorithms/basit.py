import pulp

# Define the problem
problem = pulp.LpProblem("ProjectSelection", pulp.LpMaximize)

# Decision variables
x1 = pulp.LpVariable('x1', cat='Binary')
x2 = pulp.LpVariable('x2', cat='Binary')
x3 = pulp.LpVariable('x3', cat='Binary')
x4 = pulp.LpVariable('x4', cat='Binary')
x5 = pulp.LpVariable('x5', cat='Binary')

# Objective function
problem += 10*x1 + 15*x2 + 20*x3 + 25*x4 + 30*x5

# Constraints
problem += 1000*x1 + 1500*x2 + 2000*x3 + 2500*x4 + 3000*x5 <= 7000
problem += x1 + 2*x2 + x3 + x4 + 2*x5 <= 5
problem += x1 + x2 + 2*x3 + x4 + 2*x5 <= 5
problem += x1 + x2 + x3 + 2*x4 + x5 <= 4
problem += x1 + x2 + x3 + x4 + 2*x5 <= 4
problem += x1 + x3 + x4 + x5 <= 3
problem += x1 + x2 + x4 <= 3

# Solve the problem
problem.solve()

# Print the results
for var in problem.variables():
    print(f"{var.name} = {var.varValue}")

print(f"Maximum ROI = {pulp.value(problem.objective)}")
