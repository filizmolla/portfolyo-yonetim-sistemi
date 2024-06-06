#%% BASIC IMPORTS
import itertools
import json
import os
import pulp
pulp.LpSolverDefault.msg = False

allocated_time = 20
allocated_budget = 180_000

# Load project and employee data
cwd = os.getcwd()

json_file_path = os.path.join('projects_data.json')
with open(json_file_path) as f:
    projects = json.load(f)

json_file_path = os.path.join('employees_data.json')
with open(json_file_path) as f:
    employees = json.load(f)

json_file_path = os.path.join('roles_data.json')
with open(json_file_path) as f:
    roles = json.load(f)


# Function to check if the roles required by a project are available
def are_roles_available(project, roles_data):
    for role, required in project["requirements"].items():
        for role_data in roles_data:
            if role_data["name"] == role:
                if role_data["available"] < required:
                    return False
    return True

# Function to allocate roles to a project
def allocate_roles(project, roles_data):
    for role, required in project["requirements"].items():
        for role_data in roles_data:
            if role_data["name"] == role:
                role_data["available"] -= required

# Function to deallocate roles from a project (if needed)
def deallocate_roles(project, roles_data):
    for role, required in project["requirements"].items():
        for role_data in roles_data:
            if role_data["name"] == role:
                role_data["available"] += required

project_bounds = {}
for project in projects:
    project_bounds[project['name']] = {
        "isLegalObligation": project['isLegalObligation'],
        "predictedDuration": project["predictedDuration"],
        "predictedBudget": project['predictedBudget'],
        "predictedROI": project['predictedROI'],
        "requirements": project['requirements']
    }

projects = project_bounds

projects_without_duration_constraint = {}
for proj_key, proj_value in projects.items():
    if proj_value['predictedDuration'] <= allocated_time:
        projects_without_duration_constraint[proj_key] = proj_value

projects = projects_without_duration_constraint

#%% SIMPLEX FUNCTION
# Create a binary variable for each project to indicate if it's selected or not
selected_legal = pulp.LpVariable.dicts("Project_Legal", projects.keys(), cat=pulp.LpBinary)

# Create the optimization problem for legal obligation projects
model_legal = pulp.LpProblem("Project_Selection_Legal", pulp.LpMaximize)

# Objective function: maximize total ROI for legal obligation projects
model_legal += pulp.lpSum(
    projects[proj_key]['predictedROI'] * selected_legal[proj_key]
    for proj_key in projects if projects[proj_key]['isLegalObligation']
)

# Constraint: total budget should not exceed allocated budget
model_legal += pulp.lpSum(
    projects[proj_key]['predictedBudget'] * selected_legal[proj_key]
    for proj_key in projects if projects[proj_key]['isLegalObligation']
) <= allocated_budget

# Constraint: roles required for each selected project should be available
for proj_key in projects:
    if projects[proj_key]['isLegalObligation']:
        model_legal += (
            selected_legal[proj_key] <= are_roles_available(projects[proj_key], roles)
        )

# Solve the optimization problem for legal obligation projects
model_legal.solve()

# Print selected legal obligation projects
selected_projects_legal = [proj_key for proj_key in projects if selected_legal[proj_key].value() == 1.0]
print("Selected Legal Obligation Projects:")
for proj_key in selected_projects_legal:
    print(f"{proj_key}: ROI={projects[proj_key]['predictedROI']}, Budget={projects[proj_key]['predictedBudget']}")
    allocate_roles(projects[proj_key], roles)  # Allocate roles for selected projects

# Calculate remaining budget and time
remaining_budget = allocated_budget - sum(projects[proj_key]['predictedBudget'] for proj_key in selected_projects_legal)
remaining_time = allocated_time

# Create a list of projects that are not selected yet
remaining_projects = {proj_key: projects[proj_key] for proj_key in projects if proj_key not in selected_projects_legal}

# Create a binary variable for each remaining project to indicate if it's selected or not
selected_non_legal = pulp.LpVariable.dicts("Project_NonLegal", remaining_projects.keys(), cat=pulp.LpBinary)

# Create the optimization problem for non-legal obligation projects
model_non_legal = pulp.LpProblem("Project_Selection_NonLegal", pulp.LpMaximize)

# Objective function: maximize total ROI for non-legal obligation projects
model_non_legal += pulp.lpSum(
    remaining_projects[proj_key]['predictedROI'] * selected_non_legal[proj_key]
    for proj_key in remaining_projects
)

# Constraint: total budget should not exceed remaining budget
model_non_legal += pulp.lpSum(
    remaining_projects[proj_key]['predictedBudget'] * selected_non_legal[proj_key]
    for proj_key in remaining_projects
) <= remaining_budget

# Constraint: roles required for each selected project should be available
for proj_key in remaining_projects:
    model_non_legal += (
        selected_non_legal[proj_key] <= are_roles_available(remaining_projects[proj_key], roles)
    )

# Solve the optimization problem for non-legal obligation projects
model_non_legal.solve()

# Print selected non-legal obligation projects
selected_projects_non_legal = [proj_key for proj_key in remaining_projects if selected_non_legal[proj_key].value() == 1.0]
print("\nSelected Non-Legal Obligation Projects:")
for proj_key in selected_projects_non_legal:
    print(f"{proj_key}: ROI={remaining_projects[proj_key]['predictedROI']}, Budget={remaining_projects[proj_key]['predictedBudget']}")
    allocate_roles(remaining_projects[proj_key], roles)  # Allocate roles for selected projects

# %%
