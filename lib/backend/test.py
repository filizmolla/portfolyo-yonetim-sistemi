from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from pydantic import BaseModel
from typing import List, Optional

# Database setup
DATABASE_URL = "postgresql://postgres:postgres@localhost:5432/portfolio_management_system"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

app = FastAPI()

# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Pydantic models for request/response schemas
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
    class Config:
        orm_mode = True

# Similar Pydantic models can be created for Strategy, Requirement, Employee, Role

# CRUD Operations for Project
@app.post("/projects/", response_model=Project)
def create_project(project: ProjectCreate, db: Session = Depends(get_db)):
    db_project = Project(**project.dict())
    db.add(db_project)
    db.commit()
    db.refresh(db_project)
    return db_project

@app.get("/projects/", response_model=List[Project])
def read_projects(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    projects = db.query(Project).offset(skip).limit(limit).all()
    return projects

@app.get("/projects/{project_id}", response_model=Project)
def read_project(project_id: int, db: Session = Depends(get_db)):
    project = db.query(Project).filter(Project.id == project_id).first()
    if project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    return project

@app.put("/projects/{project_id}", response_model=Project)
def update_project(project_id: int, project: ProjectCreate, db: Session = Depends(get_db)):
    db_project = db.query(Project).filter(Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    for key, value in project.dict().items():
        setattr(db_project, key, value)
    db.commit()
    db.refresh(db_project)
    return db_project

@app.delete("/projects/{project_id}")
def delete_project(project_id: int, db: Session = Depends(get_db)):
    db_project = db.query(Project).filter(Project.id == project_id).first()
    if db_project is None:
        raise HTTPException(status_code=404, detail="Project not found")
    db.delete(db_project)
    db.commit()
    return {"ok": True}

# Repeat similar CRUD routes for Strategy, Requirement, Employee, and Role

# Main function to run the FastAPI app
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
