# DAHA DETAYLI TEST EDİLMELİ
# %%
import itertools
import json
import os

# Load project and employee data
cwd = os.getcwd()

json_file_path = os.path.join("lib", "algorithms", 'projects_data.json')
with open(json_file_path) as f:
    projects = json.load(f)

json_file_path = os.path.join("lib", "algorithms", 'employees_data.json')
with open(json_file_path) as f:
    employees = json.load(f)


json_file_path = os.path.join("lib", "algorithms", 'roles_data.json')
with open(json_file_path) as f:
    roles = json.load(f)

role_names = [role['name'] for role in roles]


def eliminate_projects_based_on_duration(projects, duration):
    if any(project['predictedDuration'] > duration for project in projects):
        projects = [
            project for project in projects if project['predictedDuration'] <= duration]
    return projects


def prepare_project_baskets_based_on_available_slots(projects, roles_data):
    project_basket = []
    for r in range(len(projects) + 1):
        for subset in itertools.combinations(projects, r):
            subset_roles = {role: 0 for role in role_names}
            for project in subset:
                for role in project['requirements']:
                    subset_roles[role] += project['requirements'][role]
            roles_data = roles
            available_role_slot_counter = 0
            for role_data in roles_data:
                role_name = role_data['name']
                if subset_roles[role_name] <= role_data['available']:
                    available_role_slot_counter += 1
            if available_role_slot_counter == len(roles_data):
                project_basket.append(subset)
    return project_basket


def eliminate_baskets_based_on_budget(project_baskets, max_budget):
    new_baskets = []
    for basket in project_baskets:
        basket_budget = sum(project['predictedBudget'] for project in basket)
        if basket_budget <= max_budget:
            new_baskets.append(basket)
    return new_baskets


def get_max_legal_obligation_project_basket(project_basket):
    new_baskets = []
    max_legal_count = 0
    for basket in project_basket:
        legal_count = sum(project['isLegalObligation'] for project in basket)
        if legal_count > max_legal_count:
            max_legal_count = legal_count
    print("MAX LEGAL COUNT: ", max_legal_count)
    for basket in project_basket:
        if sum(project['isLegalObligation'] for project in basket) == max_legal_count:
            new_baskets.append(basket)
    return new_baskets


def get_max_profit_project_baskets(project_basket):
    max_profit = -9999999
    new_baskets = []
    for basket in project_basket:
        profit = sum(project['predictedReturn'] for project in basket) - \
            sum(project['predictedBudget'] for project in basket)
        if profit > max_profit:
            max_profit = profit
    print("MAX PROFIT: ", max_profit)

    for basket in project_basket:
        if sum(project['predictedReturn'] for project in basket) - sum(project['predictedBudget'] for project in basket) == max_profit:
            new_baskets.append(basket)

    return new_baskets


def brute_force(projects, duration, roles_data, budget):
    projects = eliminate_projects_based_on_duration(projects, duration)
    project_baskets = prepare_project_baskets_based_on_available_slots(
        projects, roles_data)
    print("COUNT: ", len(project_baskets))
    project_baskets = eliminate_baskets_based_on_budget(
        project_baskets, budget)
    print("COUNT: ", len(project_baskets))
    project_baskets = get_max_legal_obligation_project_basket(project_baskets)
    print("COUNT: ", len(project_baskets))
    project_baskets = get_max_profit_project_baskets(project_baskets)
    print("COUNT: ", len(project_baskets))

    for project_basket in project_baskets:
        print("Project basket:")
        for project in project_basket:
            print(project['name'])
        print("Total budget: ", sum(
            project['predictedBudget'] for project in project_basket))
        print("Total return: ", sum(
            project['predictedReturn'] for project in project_basket))
        print("Total profit: ", sum(project['predictedReturn'] for project in project_basket) - sum(
            project['predictedBudget'] for project in project_basket))
        print("--------------------------------------------------")

    return project_baskets


duration = 26
test_02 = brute_force(projects, duration, roles, 180000)
