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


def eliminate_projects_based_on_duration(projects, duration):
    if any(project['predictedDuration'] > duration for project in projects):
        projects = [
            project for project in projects if project['predictedDuration'] <= duration]
    return projects

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

@router.get("/")
def get_brute_force_results( duration: int, budget:int ,db: Session = Depends(database.get_db)):
    projects = db.query(models.Project).all()
    roles_data = db.query(models.Role).all()
    requirements = db.query(models.Requirement).all()
    projects_with_requirements = []

    projects = [project.__dict__ for project in projects]
    roles_data = [role.__dict__ for role in roles_data]
    requirements = [requirement.__dict__ for requirement in requirements]
    requirement_role_list = []
    for role_data in roles_data:
        requirement_role_list.append( role_data["name"])



    for project in projects:
        project_requirements = {}
        for requirement in requirements:

            if requirement["project_id"] == project["id"]:
                # print(project["id"])
                for role in requirement_role_list:
                    # print(role, " : ", requirement[role])
                    project_requirements[role] = requirement[role]
        projects_with_requirements.append(project)
        projects_with_requirements[-1]["requirements"] = project_requirements

           #     project_requirements[requirement.name] = requirement.count
        # project.requirements = project_requirements
        # projects_with_requirements.append(project)



    projects = eliminate_projects_based_on_duration(projects, duration)
    project_baskets = prepare_project_baskets_based_on_available_slots(projects_with_requirements, roles_data)
    print("COUNT: ", len(project_baskets))
    project_baskets = eliminate_baskets_based_on_budget(project_baskets, budget)
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
