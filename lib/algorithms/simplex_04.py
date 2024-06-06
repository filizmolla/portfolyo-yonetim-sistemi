# BASIC IMPORTS
import itertools
import json
import os
import pulp
pulp.LpSolverDefault.msg = False

allocated_time = 20
allocated_budget = 190_000

# Load project and employee data
cwd = os.getcwd()

json_file_path = os.path.join(cwd, '..', 'algorithms', 'projects_data.json')
with open(json_file_path) as f:
    projects = json.load(f)

json_file_path = os.path.join(cwd, '..', 'algorithms', 'employees_data.json')
with open(json_file_path) as f:
    employees = json.load(f)

json_file_path = os.path.join(cwd, '..', 'algorithms', 'roles_data.json')
with open(json_file_path) as f:
    roles = json.load(f)

# Extract relevant project data
project_bounds = {}
for project in projects:
    project_bounds[project['name']] = {
        "isLegalObligation": project['isLegalObligation'],
        "predictedDuration": project["predictedDuration"],
        "predictedBudget": project['predictedBudget'],
        "predictedReturn": project['predictedReturn'],
        "requirements": project.get('requirements', {})
    }

projects = project_bounds

# Filter projects by allocated time
projects_without_duration_constraint = {
    proj_key: proj_value for proj_key, proj_value in projects.items() if proj_value['predictedDuration'] <= allocated_time
}

projects = projects_without_duration_constraint

# SIMPLEX FUNCTION
selected_legal = pulp.LpVariable.dicts("Project_Legal", projects.keys(), cat=pulp.LpBinary)

# Create the optimization problem for legal obligation projects
model_legal = pulp.LpProblem("Project_Selection_Legal", pulp.LpMaximize)

# Objective function: maximize total ROI for legal obligation projects
model_legal += pulp.lpSum(projects[proj_key]['predictedReturn'] * selected_legal[proj_key] for proj_key in projects if projects[proj_key]['isLegalObligation'])

# Constraint: total budget should not exceed allocated budget
model_legal += pulp.lpSum(projects[proj_key]['predictedBudget'] * selected_legal[proj_key] for proj_key in projects if projects[proj_key]['isLegalObligation']) <= allocated_budget

# Constraint: ensure sufficient employees for each role in selected legal projects
for role_data in roles:
    role = role_data['name']
    model_legal += pulp.lpSum(selected_legal[proj_key] * projects[proj_key]['requirements'].get(role, 0) for proj_key in projects if projects[proj_key]['isLegalObligation']) <= role_data['maxSlot']

# Solve the optimization problem for legal obligation projects
model_legal.solve()

# Print selected legal obligation projects
selected_projects_legal = [proj_key for proj_key in projects if selected_legal[proj_key].value() == 1.0]
print("Selected Legal Obligation Projects:")
for proj_key in selected_projects_legal:
    print(f"{proj_key}: ROI={projects[proj_key]['predictedReturn']}, Budget={projects[proj_key]['predictedBudget']}")

# Update maxSlots based on selected legal projects
for proj_key in selected_projects_legal:
    for role, count in projects[proj_key]['requirements'].items():
        for role_data in roles:
            if role == role_data['name']:
                role_data['occupied'] += count
                role_data['available'] = role_data['maxSlot'] - role_data['occupied']

# Calculate remaining budget after selecting legal projects
remaining_budget = allocated_budget - sum(projects[proj_key]['predictedBudget'] for proj_key in selected_projects_legal)
remaining_time = allocated_time

# Create a list of non-legal obligation projects that are not selected yet
remaining_projects_non_legal = {
    proj_key: projects[proj_key] for proj_key in projects if proj_key not in selected_projects_legal
}

# Create a binary variable for each remaining non-legal project to indicate if it's selected or not
selected_non_legal = pulp.LpVariable.dicts("Project_NonLegal", remaining_projects_non_legal.keys(), cat=pulp.LpBinary)

# Create the optimization problem for non-legal obligation projects
model_non_legal = pulp.LpProblem("Project_Selection_NonLegal", pulp.LpMaximize)

# Objective function: maximize total ROI for non-legal obligation projects
model_non_legal += pulp.lpSum(remaining_projects_non_legal[proj_key]['predictedReturn'] * selected_non_legal[proj_key] for proj_key in remaining_projects_non_legal)

# Constraint: total budget should not exceed remaining budget after legal projects
model_non_legal += pulp.lpSum(remaining_projects_non_legal[proj_key]['predictedBudget'] * selected_non_legal[proj_key] for proj_key in remaining_projects_non_legal) <= remaining_budget

# Constraint: ensure sufficient employees for each role in selected non-legal projects
for role_data in roles:
    role = role_data['name']
    if any(role in proj['requirements'] for proj in remaining_projects_non_legal.values()):
        model_non_legal += pulp.lpSum(selected_non_legal[proj_key] * remaining_projects_non_legal[proj_key]['requirements'].get(role, 0) for proj_key in remaining_projects_non_legal) <= max(0, role_data['available'])

# Solve the optimization problem for non-legal obligation projects
model_non_legal.solve()

# Print selected non-legal obligation projects
selected_projects_non_legal = [proj_key for proj_key in remaining_projects_non_legal if selected_non_legal[proj_key].value() == 1.0]
print("\nSelected Non-Legal Obligation Projects:")
for proj_key in selected_projects_non_legal:
    print(f"{proj_key}: ROI={remaining_projects_non_legal[proj_key]['predictedReturn']}, Budget={remaining_projects_non_legal[proj_key]['predictedBudget']}")
