from psycopg2 import sql
import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, ARRAY, Boolean
from sqlalchemy.orm import declarative_base, relationship

# create a database connection
engine = create_engine('postgresql://postgres:postgres@localhost:5432/portfolio_management_system')

# create tables and columns from json files

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

json_file_path = os.path.join("lib", "algorithms", 'requirements.json')
with open(json_file_path) as f:
    requirements = json.load(f)

json_file_path = os.path.join("lib", "algorithms", 'strategies.json')
with open(json_file_path) as f:
    strategies = json.load(f)

# Create a base class
Base = declarative_base()


class Project(Base):
    __tablename__ = 'projects'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String)
    description = Column(String)
    projectScope = Column(String)
    projectManager = Column(String)
    criticalImportanceLevel = Column(Integer)
    isLegalObligation = Column(Boolean)
    minBudget = Column(Integer)
    maxBudget = Column(Integer)
    predictedBudget = Column(Integer)
    minDuration = Column(Integer)
    maxDuration = Column(Integer)
    predictedDuration = Column(Integer)
    projectDifficulty = Column(Integer)
    minReturn = Column(Integer)
    maxReturn = Column(Integer)
    predictedReturn = Column(Integer)
    successMetrics = Column(String)
    sponsors = Column(ARRAY(String))
    priority = Column(Integer)
    isApproved = Column(Boolean)

    strategies = relationship("Strategy", back_populates="project")
    requirements = relationship("Requirement", back_populates="project")


class Strategy(Base):
    __tablename__ = 'strategies'

    id = Column(Integer, primary_key=True, autoincrement=True)
    project_id = Column(Integer, ForeignKey('projects.id'))
    customer_satisfaction = Column(Integer)
    future_goals = Column(Integer)
    employee_satisfaction = Column(Integer)

    project = relationship("Project", back_populates="strategies")


class Requirement(Base):
    __tablename__ = 'requirements'

    id = Column(Integer, primary_key=True, autoincrement=True)
    project_id = Column(Integer, ForeignKey('projects.id'))
    backend_developer = Column(Integer)
    frontend_developer = Column(Integer)
    analyst = Column(Integer)
    quality_assurance_tester = Column(Integer)
    devops = Column(Integer)
    database_developer = Column(Integer)

    # Define the relationship with the Project table
    project = relationship("Project", back_populates="requirements")


class Employee(Base):
    __tablename__ = 'employees'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String)
    surname = Column(String)
    salary = Column(Integer)
    role = Column(String)
    maxProjects = Column(Integer)
    currentProjectsCount = Column(Integer)


class Role(Base):
    __tablename__ = 'roles'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String)
    maxSlot = Column(Integer)
    occupied = Column(Integer)
    available = Column(Integer)


# Create the table in the database
Base.metadata.create_all(engine)


# Insert data into the tables
from sqlalchemy.orm import sessionmaker

# Create a session
Session = sessionmaker(bind=engine)
session = Session()

# Insert data into the roles table
for role in roles:
    new_role = Role(name=role['name'], maxSlot=role['maxSlot'], occupied=role['occupied'], available=role['available'])
    session.add(new_role)

session.commit()

# Insert data into the employees table
for employee in employees:
    new_employee = Employee(name=employee['name'], surname=employee['surname'], salary=employee['salary'], role=employee['role'], maxProjects=employee['maxProjects'], currentProjectsCount=employee['currentProjectsCount'])
    session.add(new_employee)
session.commit()

# Insert data into the projects table
for project in projects:
    new_project = Project(name=project['name'], description=project['description'], projectScope=project['projectScope'], projectManager=project['projectManager'], criticalImportanceLevel=project['criticalImportanceLevel'], isLegalObligation=project['isLegalObligation'], minBudget=project['minBudget'], maxBudget=project['maxBudget'], predictedBudget=project['predictedBudget'], minDuration=project['minDuration'], maxDuration=project['maxDuration'], predictedDuration=project['predictedDuration'], projectDifficulty=project['projectDifficulty'], minReturn=project['minReturn'], maxReturn=project['maxReturn'], predictedReturn=project['predictedReturn'], successMetrics=project['successMetrics'], sponsors=project['sponsors'], priority=project['priority'], isApproved=project['isApproved'])
    session.add(new_project)
session.commit()

# Insert data into the requirements table
for requirement in requirements:
    new_requirement = Requirement(project_id=requirement['project_id'], backend_developer=requirement['backend developer'], frontend_developer=requirement['frontend developer'], analyst=requirement['analyst'], quality_assurance_tester=requirement['quality assurance tester'], devops=requirement['devops'], database_developer=requirement['database developer'])
    session.add(new_requirement)
session.commit()

# Insert data into the strategies table
for strategy in strategies:
    new_strategy = Strategy(project_id=strategy['project_id'], customer_satisfaction=strategy['customer_satisfaction'], future_goals=strategy['future_goals'], employee_satisfaction=strategy['employee_satisfaction'])
    session.add(new_strategy)
session.commit()

session.close()
