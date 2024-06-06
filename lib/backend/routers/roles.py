from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from .. import models, schemas, database

router = APIRouter(
    prefix="/roles",
    tags=["roles"],
    responses={404: {"description": "Not found"}},
)

@router.post("/", response_model=schemas.Role)
def create_role(role: schemas.RoleCreate, db: Session = Depends(database.get_db)):
    db_role = models.Role(**role.dict())
    db.add(db_role)
    db.commit()
    db.refresh(db_role)
    return db_role

@router.get("/", response_model=List[schemas.Role])
def read_roles( db: Session = Depends(database.get_db)):
    roles = db.query(models.Role)
    return roles

@router.get("/{role_id}", response_model=schemas.Role)
def read_role(role_id: int, db: Session = Depends(database.get_db)):
    role = db.query(models.Role).filter(models.Role.id == role_id).first()
    if role is None:
        raise HTTPException(status_code=404, detail="Role not found")
    return role

@router.put("/{role_id}", response_model=schemas.Role)
def update_role(role_id: int, role: schemas.RoleCreate, db: Session = Depends(database.get_db)):
    db_role = db.query(models.Role).filter(models.Role.id == role_id).first()
    if db_role is None:
        raise HTTPException(status_code=404, detail="Role not found")
    for key, value in role.dict().items():
        setattr(db_role, key, value)
    db.commit()
    db.refresh(db_role)
    return db_role

@router.delete("/{role_id}")
def delete_role(role_id: int, db: Session = Depends(database.get_db)):
    db_role = db.query(models.Role).filter(models.Role.id == role_id).first()
    if db_role is None:
        raise HTTPException(status_code=404, detail="Role not found")
    db.delete(db_role)
    db.commit()
    return {"ok": True}
