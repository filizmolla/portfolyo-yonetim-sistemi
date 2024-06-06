#%% BASIC IMPORTS
import itertools
import json
import os
import pulp


# Load project and employee data
cwd = os.getcwd()

json_file_path = os.path.join( 'projects_data.json')
with open(json_file_path) as f:
    projects = json.load(f)

json_file_path = os.path.join('employees_data.json')
with open(json_file_path) as f:
    employees = json.load(f)


#%% SIMPLEX FUNCTION
model = pulp.LpProblem("Business_Portfolio_Optimization", pulp.LpMaximize)


project_bounds = {}
for project in projects:
    project_bounds[project['name']] = {"isLegalObligation": project['isLegalObligation'], "predictedDuration": project["predictedDuration"], "predictedBudget": project['predictedBudget'], "predictedROI": project['predictedROI']}

projects = project_bounds



# Değişkenler
project_vars = {proj: pulp.LpVariable(proj, cat='Binary') for proj in projects}


# Amaç fonksiyonu: Getiriyi maksimize et
model += pulp.lpSum([projects[proj]['predictedROI'] * project_vars[proj] for proj in projects]), "Total Return"

# Kısıtlar
# Yasal zorunluluk
for proj in projects:
    if projects[proj]['isLegalObligation']:
        model += project_vars[proj] == 1, f"Legal_Requirement_{proj}"

# Bütçe kısıtı
allocated_budget = 180_000
model += pulp.lpSum([projects[proj]['predictedBudget'] * project_vars[proj] for proj in projects]) <= allocated_budget, "Budget_Constraint"

# Zaman kısıtı
allocated_time = 64
for proj in projects:

    model += project_vars[proj] * projects[proj]['predictedDuration'] <= allocated_time, f"Time_Constraint_{proj}"



# Modeli çöz
model.solve()

# Sonuçlar
print("Çözüm Durumu:", pulp.LpStatus[model.status])
print("Seçilen Projeler:")
for proj in projects:
    if project_vars[proj].varValue == 1:
        print(proj)



print("Toplam Getiri:", pulp.value(model.objective))


# %%
