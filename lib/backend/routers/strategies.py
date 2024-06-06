from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from lib.backend import models, schemas, database

router = APIRouter(
    prefix="/strategies",
    tags=["strategies"],
    responses={404: {"description": "Not found"}},
)

@router.post("/", response_model=schemas.Strategy)
def create_strategy(strategy: schemas.StrategyCreate, db: Session = Depends(database.get_db)):
    db_strategy = models.Strategy(**strategy.dict())
    db.add(db_strategy)
    db.commit()
    db.refresh(db_strategy)
    return db_strategy

@router.get("/", response_model=List[schemas.Strategy])
def read_strategies( db: Session = Depends(database.get_db)):
    strategies = db.query(models.Strategy)
    return strategies

@router.get("/{strategy_id}", response_model=schemas.Strategy)
def read_strategy(strategy_id: int, db: Session = Depends(database.get_db)):
    strategy = db.query(models.Strategy).filter(models.Strategy.id == strategy_id).first()
    if strategy is None:
        raise HTTPException(status_code=404, detail="Strategy not found")
    return strategy

@router.put("/{strategy_id}", response_model=schemas.Strategy)
def update_strategy(strategy_id: int, strategy: schemas.StrategyCreate, db: Session = Depends(database.get_db)):
    db_strategy = db.query(models.Strategy).filter(models.Strategy.id == strategy_id).first()
    if db_strategy is None:
        raise HTTPException(status_code=404, detail="Strategy not found")
    for key, value in strategy.dict().items():
        setattr(db_strategy, key, value)
    db.commit()
    db.refresh(db_strategy)
    return db_strategy

@router.delete("/{strategy_id}")
def delete_strategy(strategy_id: int, db: Session = Depends(database.get_db)):
    db_strategy = db.query(models.Strategy).filter(models.Strategy.id == strategy_id).first()
    if db_strategy is None:
        raise HTTPException(status_code=404, detail="Strategy not found")
    db.delete(db_strategy)
    db.commit()
    return {"ok": True}
