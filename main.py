from fastapi import FastAPI, Request, Body
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
import random
origins = [
    "http://localhost:4200"
]

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


@app.post("/api/configuration")
async def configuration(request: Request):
    body = await request.json()
    print(body)
    return body

@app.get("/api/link/flow/{link_id}")
async def get_link_data(link_id: str):
    current_date = str(datetime.now())
    data = [{"linkID": i, "data": random.randrange(0, 50), "type": "flow", "date": current_date} for i in link_id.split(";")]
    return data
