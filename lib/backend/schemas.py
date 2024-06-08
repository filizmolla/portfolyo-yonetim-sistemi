from pydantic import BaseModel
from typing import List, Optional

class StrategyBase(BaseModel):
    customer_satisfaction: int
    future_goals: int
    employee_satisfaction: int

class StrategyCreate(StrategyBase):
    pass

class Strategy(StrategyBase):
    id: int
    project_id: int

    class Config:
        orm_mode = True

class RequirementBase(BaseModel):
    backend_developer: int
    frontend_developer: int
    analyst: int
    quality_assurance_tester: int
    devops: int
    database_developer: int

class RequirementCreate(RequirementBase):
    pass

class Requirement(RequirementBase):
    id: int
    project_id: int

    class Config:
        orm_mode = True

class ProjectBase(BaseModel):
    name: str
    description: Optional[str] = None
    projectScope: Optional[str] = None
    projectManager: Optional[str] = None
    criticalImportanceLevel: Optional[int] = None
    isLegalObligation: Optional[bool] = None
    minBudget: Optional[int] = None
    maxBudget: Optional[int] = None
    predictedBudget: Optional[int] = None
    minDuration: Optional[int] = None
    maxDuration: Optional[int] = None
    predictedDuration: Optional[int] = None
    projectDifficulty: Optional[int] = None
    minReturn: Optional[int] = None
    maxReturn: Optional[int] = None
    predictedReturn: Optional[int] = None
    successMetrics: Optional[str] = None
    sponsors: Optional[List[str]] = None
    priority: Optional[int] = None
    isApproved: Optional[bool] = None

class ProjectCreate(ProjectBase):
    pass

class Project(ProjectBase):
    id: int
    strategies: List[Strategy] = []
    requirements: List[Requirement] = []

    class Config:
        orm_mode = True

class EmployeeBase(BaseModel):
    name: str
    surname: str
    salary: int
    role: str
    maxProjects: int
    currentProjectsCount: int

class EmployeeCreate(EmployeeBase):
    pass

class Employee(EmployeeBase):
    id: int

    class Config:
        orm_mode = True

class RoleBase(BaseModel):
    name: str
    maxSlot: int
    occupied: int
    available: int

class RoleCreate(RoleBase):
    pass

class Role(RoleBase):
    id: int

    class Config:
        orm_mode = True