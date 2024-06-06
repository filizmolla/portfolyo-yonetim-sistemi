from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, ARRAY
from sqlalchemy.orm import relationship
from .database import Base

class Project(Base):
    __tablename__ = 'projects'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String, index=True)
    projectScope = Column(String, index=True)
    projectManager = Column(String, index=True)
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
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, ForeignKey('projects.id'))
    customer_satisfaction = Column(Integer)
    future_goals = Column(Integer)
    employee_satisfaction = Column(Integer)

    project = relationship("Project", back_populates="strategies")

class Requirement(Base):
    __tablename__ = 'requirements'
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, ForeignKey('projects.id'))
    backend_developer = Column(Integer)
    frontend_developer = Column(Integer)
    analyst = Column(Integer)
    quality_assurance_tester = Column(Integer)
    devops = Column(Integer)
    database_developer = Column(Integer)

    project = relationship("Project", back_populates="requirements")

class Employee(Base):
    __tablename__ = 'employees'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    surname = Column(String, index=True)
    salary = Column(Integer)
    role = Column(String)
    maxProjects = Column(Integer)
    currentProjectsCount = Column(Integer)

class Role(Base):
    __tablename__ = 'roles'
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    maxSlot = Column(Integer)
    occupied = Column(Integer)
    available = Column(Integer)
