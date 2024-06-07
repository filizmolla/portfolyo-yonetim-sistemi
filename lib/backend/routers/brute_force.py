import itertools
import json
import os
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from lib.backend import models, database

router = APIRouter(
    prefix="/brute_force",
    tags=["brute_force"],
    responses={404: {"description": "Not found"}},
)


def eliminate_projects_based_on_duration(projects, duration, case):
    field = ""
    if case == "predicted":
        field = 'predictedDuration'
    elif case == "worst":
        field = 'maxDuration'
    elif case == "best":
        field = 'minDuration'
    if any(project[field] > duration for project in projects):
        projects = [
            project for project in projects if project[field] <= duration]
    return projects



def eliminate_projects_based_on_strategies(projects, strategies_input):
    new_projects = []
    strategies_input_keys = list(strategies_input.keys())
    strategies_legth = len(strategies_input_keys)
    for project in projects:
        if project["isLegalObligation"] == True:
            new_projects.append(project)
        else:
            counter = 0
            for strategies_input_key in strategies_input_keys:
                if project["strategies"][strategies_input_key] >= strategies_input[strategies_input_key]:
                    counter += 1
            if counter == strategies_legth:
                    new_projects.append(project)
    return new_projects



def prepare_project_baskets_based_on_available_slots(projects, roles_data):
    project_basket = []
    role_names = [role['name'] for role in roles_data]
    print(role_names)
    for r in range(len(projects) + 1):
        for subset in itertools.combinations(projects, r):
            subset_roles = {role: 0 for role in role_names}
            for project in subset:
                for role in project['requirements']:
                    subset_roles[role] += project['requirements'][role]
            # roles_data = roles  # explain
            available_role_slot_counter = 0
            for role_data in roles_data:
                role_name = role_data['name']
                if subset_roles[role_name] <= role_data['available']:
                    available_role_slot_counter += 1
            if available_role_slot_counter == len(roles_data):
                project_basket.append(subset)
    return project_basket



def eliminate_baskets_based_on_budget(project_baskets, max_budget, case):

    field = ""
    if case == "predicted":
        field = 'predictedBudget'
    elif case == "worst":
        field = 'maxBudget'
    elif case == "best":
        field = 'minBudget'


    new_baskets = []
    for basket in project_baskets:
        basket_budget = sum(project[field] for project in basket)
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



def get_max_profit_project_baskets(project_basket,case):
    return_field = ""
    budget_field = ""

    if case == "predicted":
        return_field = "predictedReturn"
        budget_field = "predictedBudget"
    elif case == "worst":
        return_field = "minReturn"
        budget_field = "maxBudget"
    elif case == "best":
        return_field = "maxReturn"
        budget_field = "minBudget"

    max_profit = -9999999
    new_baskets = []
    for basket in project_basket:
        profit = sum(project[return_field] for project in basket) - \
            sum(project[budget_field] for project in basket)
        if profit > max_profit:
            max_profit = profit
    print("MAX PROFIT: ", max_profit)

    for basket in project_basket:
        if sum(project[return_field] for project in basket) - sum(project[budget_field] for project in basket) == max_profit:
            new_baskets.append(basket)

    return new_baskets




@router.get("/")
def get_brute_force_predicted_results( duration: int, budget:int, case: str, customer_satisfaction:int,future_goals:int,employee_satisfaction:int ,db: Session = Depends(database.get_db)):
    if case not in ["predicted", "worst", "best"]:
        raise HTTPException(status_code=404, detail="Case should be one of the following: predicted, worst, best")
    # case = "predicted"
    projects = db.query(models.Project).all()
    roles_data = db.query(models.Role).all()
    requirements = db.query(models.Requirement).all()
    strategies = db.query(models.Strategy).all()
    # get strategies table's column names as a list
    strategies_name_list = list(strategies[0].__dict__.keys())

    strategies_name_list.remove('_sa_instance_state')
    strategies_name_list.remove('id')
    strategies_name_list.remove('project_id')

    projects_with_requirements_and_strategies = []

    projects = [project.__dict__ for project in projects]
    roles_data = [role.__dict__ for role in roles_data]
    requirements = [requirement.__dict__ for requirement in requirements]
    strategies = [strategy.__dict__ for strategy in strategies]
    requirement_role_list = []
    for role_data in roles_data:
        requirement_role_list.append( role_data["name"])



    for project in projects:
        project_requirements = {}
        project_strategies = {}
        for requirement in requirements:
            if requirement["project_id"] == project["id"]:
                # print(project["id"])
                for role in requirement_role_list:
                    # print(role, " : ", requirement[role])
                    project_requirements[role] = requirement[role]
        for strategy in strategies:
            if strategy["project_id"] == project["id"]:
                for strategy_name in strategies_name_list:
                    project_strategies[strategy_name] = strategy[strategy_name]
        projects_with_requirements_and_strategies.append(project)
        projects_with_requirements_and_strategies[-1]["requirements"] = project_requirements
        projects_with_requirements_and_strategies[-1]["strategies"] = project_strategies
           #     project_requirements[requirement.name] = requirement.count
        # project.requirements = project_requirements
        # projects_with_requirements_and_strategies.append(project)

    strategies_input = {
        "customer_satisfaction": customer_satisfaction,
        "future_goals": future_goals,
        "employee_satisfaction": employee_satisfaction
    }

    projects = eliminate_projects_based_on_duration(projects, duration, case)
    print("AFTER DURATION COUNT: ", len(projects))
    projects = eliminate_projects_based_on_strategies(projects, strategies_input)
    print("AFTER STRATEGIES COUNT: ", len(projects))

    project_baskets = prepare_project_baskets_based_on_available_slots(projects_with_requirements_and_strategies, roles_data)
    print("COUNT: ", len(project_baskets))
    project_baskets = eliminate_baskets_based_on_budget(project_baskets, budget, case)
    print("COUNT: ", len(project_baskets))
    project_baskets = get_max_legal_obligation_project_basket(project_baskets)
    print("COUNT: ", len(project_baskets))
    project_baskets = get_max_profit_project_baskets(project_baskets, case)
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

    print(type(project_baskets))
    print(type(project_baskets[0]))

    project_basket_summary = {}
    budget_label = ""
    duration_label = ""
    return_label = ""

    if case == "predicted":
        budget_label= "predictedBudget"
        duration_label= "predictedDuration"
        return_label = "predictedReturn"
    elif case == "worst":
        budget_label= "maxBudget"
        duration_label= "maxDuration"
        return_label = "minReturn"
    elif case == "best":
        budget_label= "minBudget"
        duration_label= "minDuration"
        return_label = "maxReturn"


    project_basket_summary["all_info"] = project_baskets[0]
    project_basket_summary["project_names"] = [project['name'] for project in project_baskets[0]]
    project_basket_summary["total_budget"] = sum(project[budget_label] for project in project_baskets[0])
    project_basket_summary["total_return"] = sum(project[return_label] for project in project_baskets[0])
    project_basket_summary["total_profit"] = sum(project[return_label] for project in project_baskets[0]) - sum(project[budget_label] for project in project_baskets[0])

    print(project_basket_summary["project_names"])
    print(project_basket_summary["total_budget"])
    print(project_basket_summary["total_return"])
    print(project_basket_summary["total_profit"])

    return project_baskets, project_basket_summary


