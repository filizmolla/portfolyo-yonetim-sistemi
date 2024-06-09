from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from lib.backend import models, schemas, database

router = APIRouter(
    prefix="/projects",
    tags=["projects"],
    responses={404: {"description": "Not found"}},
)

@router.post("/", response_model=schemas.Project)
def create_project(project: schemas.ProjectCreate, strategies: schemas.StrategyCreate, requirements: schemas.RequirementCreate, db: Session = Depends(database.get_db)):
    db_project = models.Project(**project.dict())
    db.add(db_project)
    db.commit()
    db.refresh(db_project)

    db_strategy = models.Strategy(**strategies.dict(exclude={'project_id'}), project_id=db_project.id)
    db.add(db_strategy)

    db_requirements = models.Requirement(**requirements.dict(exclude={'project_id'}), project_id=db_project.id)
    db.add(db_requirements)

    db.commit()
    return db_project

@router.get("/", response_model=List[schemas.Project])
def read_projects( db: Session = Depends(database.get_db)):
    projects = db.query(models.Project)
    return projects

@router.get("/approved_projects", response_model=List[schemas.Project])
def read_approved_projects( db: Session = Depends(database.get_db)):
    projects = db.query(models.Project).filter(models.Project.isApproved == True).all()
    return projects

@router.get("/non_approved_projects", response_model=List[schemas.Project])
def read_non_approved_projects( db: Session = Depends(database.get_db)):
    projects = db.query(models.Project).filter(models.Project.isApproved == False).all()
    return projects

@router.get("/{project_id}", response_model=schemas.Project)
def read_project(project_id: int, db: Session = Depends(database.get_db)):
    project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    return project

@router.put("/{project_id}", response_model=schemas.Project)
def update_project(project_id: int, project: schemas.ProjectCreate, strategies: schemas.StrategyCreate, requirements: schemas.RequirementCreate, db: Session = Depends(database.get_db)):
    db_project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")

    # Update project fields
    for key, value in project.dict().items():
        setattr(db_project, key, value)

    # Update project strategies
    db.query(models.Strategy).filter(models.Strategy.project_id == project_id).delete()
    db_strategy = models.Strategy(**strategies.dict(), project_id=project_id)
    db.add(db_strategy)

    # Update project requirements
    db.query(models.Requirement).filter(models.Requirement.project_id == project_id).delete()
    db_requirements = models.Requirement(**requirements.dict(), project_id=project_id)
    db.add(db_requirements)

    db.commit()
    db.refresh(db_project)
    return db_project



@router.delete("/{project_id}")
def delete_project(project_id: int, db: Session = Depends(database.get_db)):
    db_project = db.query(models.Project).filter(models.Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")

    # Delete project strategies
    db.query(models.Strategy).filter(models.Strategy.project_id == project_id).delete()

    # Delete project requirements
    db.query(models.Requirement).filter(models.Requirement.project_id == project_id).delete()

    # Delete the project
    db.delete(db_project)
    db.commit()
    return {"ok": True}