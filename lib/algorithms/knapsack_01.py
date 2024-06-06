# VERY BASIC IMPLEMENTATION OF KNAPSACK ALGORITHM


import json
import os

cwd = os.getcwd()

json_file_path = os.path.join('projects_data.json')

with open(json_file_path) as f:
    projects = json.load(f)

def knapsack(projects, max_budget):
    n = len(projects)
    dp = [[0 for _ in range(max_budget + 1)] for _ in range(n + 1)]
    for i in range(1, n + 1):
        budget = projects[i - 1]['predictedBudget']
        roi= projects[i - 1]['predictedROI']
        for j in range(1, max_budget + 1):
            if projects[i - 1]['predictedBudget'] > j:
                dp[i][j] = dp[i - 1][j]
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - projects[i - 1]['predictedBudget']] + projects[i - 1]['predictedROI'])
    max_roi = dp[n][max_budget]
    included_projects = []
    i,j = n, max_budget


    while i > 0 and j > 0:
        if dp[i][j] != dp[i - 1][j]:
            included_projects.append(projects[i - 1]['name'])
            j -= projects[i - 1]['predictedBudget']
        i -= 1

    return max_roi, included_projects


test = knapsack(projects, 50000)
print(test)
