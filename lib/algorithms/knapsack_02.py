# IMPLEMENTATION WITH LEGAL OBLIGATIONS

import json
import os

cwd = os.getcwd()

json_file_path = os.path.join('projects_data.json')

with open(json_file_path) as f:
    projects = json.load(f)

def knapsack_with_legal_obligations_check(projects, max_budget):
    if any(project['isLegalObligation'] == True for project in projects):
        total = 0
        legal_obligations = []
        for project in projects:
            if project['isLegalObligation'] == True:
                legal_obligations.append(project)
                total += project["predictedBudget"]
        non_legal_projects = [project for project in projects if project not in legal_obligations]
        
        if total > max_budget: # legal'ların bir kısmını yap ama knapsack ile seç. geri kalan para ile eğer yetiyorsa diğer projeleri yap
            max_roi, included_projects, remaining_budget = knapsack(legal_obligations, max_budget)
            knapsack(non_legal_projects, remaining_budget)
        elif total == max_budget:
            print("ROI: ", sum([project['predictedROI'] for project in legal_obligations]))
            print("project names: ", [project['name'] for project in legal_obligations])
            print("Remaining budget: ", 0)
            return sum([project['predictedROI'] for project in legal_obligations]), [project['name'] for project in legal_obligations], 0
        else: # legal'ları yaptıktan sonra paran kalıyor
            new_max_budget = max_budget - total
            print("ROI: ", sum([project['predictedROI'] for project in legal_obligations]))
            print("project names: ", [project['name'] for project in legal_obligations])
            print("Remaining budget: ", new_max_budget)
            knapsack(non_legal_projects, new_max_budget)

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
    print("ROI: ", max_roi)
    print("Project names: ", included_projects)
    print("Remaining budget: ", j)
    remaining_budget = j
    return max_roi, included_projects, remaining_budget


print("TEST 01 - MAX BUDGET: 50_000")
test_01 = knapsack_with_legal_obligations_check(projects, 50000)
print("--------------------------------------")
print("\n")
print("TEST 02 - MAX BUDGET: 100_000")
test_02 = knapsack_with_legal_obligations_check(projects, 100000)
print("--------------------------------------")
print("\n")
print("TEST 03 - MAX BUDGET: 70_000")
test_03 = knapsack_with_legal_obligations_check(projects, 70000)
print("--------------------------------------")
print("\n")
print("TEST 04 - MAX BUDGET: 30_000")
test_04 = knapsack_with_legal_obligations_check(projects, 30000)
print("--------------------------------------")
print("\n")
print("TEST 05 - MAX BUDGET: 2_000_000")
test_05 = knapsack_with_legal_obligations_check(projects, 2_000_000)
print("--------------------------------------")
