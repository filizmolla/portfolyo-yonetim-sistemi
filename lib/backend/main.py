import uvicorn
from starlette.middleware.cors import CORSMiddleware

from lib.backend.routers import projects, strategies, requirements, employees, roles, brute_force
from lib.backend.database import Base, engine
from fastapi import FastAPI

# Create the database tables
Base.metadata.create_all(bind=engine)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # İstediğiniz domain'leri burada belirleyin, "*" tümünü ifade eder.
    allow_credentials=True,
    allow_methods=["*"],  # İzin verilen HTTP metodları
    allow_headers=["*"],  # İzin verilen HTTP header'ları
)
# Include the routers
app.include_router(projects.router)
app.include_router(strategies.router)
app.include_router(requirements.router)
app.include_router(employees.router)
app.include_router(roles.router)
app.include_router(brute_force.router)


# Optionally define a root route
@app.get("/")
def read_root():
    return {"message": "Welcome to the Portfolio Management System API"}


if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
