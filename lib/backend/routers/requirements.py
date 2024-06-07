from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from .. import models, schemas, database

router = APIRouter(
    prefix="/requirements",
    tags=["requirements"],
    responses={404: {"description": "Not found"}},
)


@router.post("/", response_model=schemas.Requirement)
def create_requirement(requirement: schemas.RequirementCreate, db: Session = Depends(database.get_db)):
    db_requirement = models.Requirement(**requirement.dict())
    db.add(db_requirement)
    db.commit()
    db.refresh(db_requirement)
    return db_requirement


@router.get("/", response_model=List[schemas.Requirement])
def read_requirements(db: Session = Depends(database.get_db)):
    requirements = db.query(models.Requirement)
    return requirements


@router.get("/{requirement_id}", response_model=schemas.Requirement)
def read_requirement(requirement_id: int, db: Session = Depends(database.get_db)):
    requirement = db.query(models.Requirement).filter(
        models.Requirement.id == requirement_id).first()
    if requirement is None:
        raise HTTPException(status_code=404, detail="Requirement not found")
    return requirement


@router.put("/{requirement_id}", response_model=schemas.Requirement)
def update_requirement(requirement_id: int, requirement: schemas.RequirementCreate, db: Session = Depends(database.get_db)):
    db_requirement = db.query(models.Requirement).filter(
        models.Requirement.id == requirement_id).first()
    if db_requirement is None:
        raise HTTPException(status_code=404, detail="Requirement not found")
    for key, value in requirement.dict().items():
        setattr(db_requirement, key, value)
    db.commit()
    db.refresh(db_requirement)
    return db_requirement


@router.delete("/{requirement_id}")
def delete_requirement(requirement_id: int, db: Session = Depends(database.get_db)):
    db_requirement = db.query(models.Requirement).filter(
        models.Requirement.id == requirement_id).first()
    if db_requirement is None:
        raise HTTPException(status_code=404, detail="Requirement not found")
    db.delete(db_requirement)
    db.commit()
    return {"ok": True}
