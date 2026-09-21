# =============================================================================
# EDUCATIONAL ASSESSMENT API
# =============================================================================
# This is a REST API built with FastAPI.
# It demonstrates the basic patterns you'll see in real-world APIs.
# =============================================================================

# -----------------------------------------------------------------------------
# IMPORTS
# -----------------------------------------------------------------------------
# FastAPI - the web framework that handles HTTP requests/responses
# HTTPException - used to return error responses (like 404 Not Found)
from fastapi import FastAPI, HTTPException, status

# Pydantic - handles data validation and serialization
# BaseModel - we inherit from this to define the structure of our data
from pydantic import BaseModel

# No typing imports needed - using Python 3.9+ built-in generics

# -----------------------------------------------------------------------------
# PYDANTIC MODELS (Data Structures)
# -----------------------------------------------------------------------------
# These define WHAT data looks like. Pydantic validates incoming data
# automatically. If someone sends invalid data, FastAPI returns a 422 error.

class QuestionBase(BaseModel):
    """
    Base fields that all questions have.
    We separate this so we can reuse it.
    """
    question: str           # The question text (required)
    answer: str             # The correct answer (required)
    difficulty: str         # "easy", "medium", or "hard" (required)


class QuestionCreate(QuestionBase):
    """
    Used when CREATING a new question.
    Inherits all fields from QuestionBase.
    Notice: no 'id' field - the server assigns the ID.
    """
    pass  # No additional fields needed


class Question(QuestionBase):
    """
    The full question object (what we return to clients).
    Includes the ID that the server assigned.
    """
    id: int  # Server-assigned unique identifier


# -----------------------------------------------------------------------------
# IN-MEMORY DATABASE
# -----------------------------------------------------------------------------
# For learning purposes, we store data in a Python list.
# When the server restarts, this data is lost.
# In production, you'd use a real database (PostgreSQL, MySQL, etc.)

questions_db: list[dict] = [
    {
        "id": 1,
        "question": "What is the capital of France?",
        "answer": "Paris",
        "difficulty": "easy"
    },
    {
        "id": 2,
        "question": "What is 15 * 17?",
        "answer": "255",
        "difficulty": "medium"
    },
    {
        "id": 3,
        "question": "What year did World War II end?",
        "answer": "1945",
        "difficulty": "easy"
    }
]

# Counter for generating unique IDs
# Start at 4 since we already have 3 questions
next_id = 4

# -----------------------------------------------------------------------------
# CREATE THE FASTAPI APPLICATION
# -----------------------------------------------------------------------------
# This is the main application object. All routes are attached to it.

app = FastAPI(
    title="Educational Assessment API",
    description="A simple API for managing assessment questions",
    version="1.0.0"
)

# -----------------------------------------------------------------------------
# ROUTES (Endpoints)
# -----------------------------------------------------------------------------
# Each route handles a specific HTTP method + URL combination.
# The decorator (@app.get, @app.post, etc.) tells FastAPI which requests
# should trigger which function.

# ---- Health Check ----
# This is a standard pattern. Monitoring tools, load balancers, and
# orchestration systems (like Kubernetes) use this to check if the
# service is running.

@app.get("/health")
def health_check():
    """
    Health check endpoint.
    Returns 200 OK if the service is running.
    """
    return {"status": "healthy", "service": "assessment-api", "version": "1.0.1"}


# ---- Get All Questions ----
# Returns the complete list of questions.

@app.get("/questions", response_model=list[Question])
def get_questions():
    """
    Retrieve all questions.

    response_model=List[Question] tells FastAPI:
    - Validate that we're returning a list of Question objects
    - Generate accurate API documentation
    """
    return questions_db


# ---- Get Single Question ----
# The {question_id} in the path becomes a function parameter.
# FastAPI automatically converts it to an integer.

@app.get("/questions/{question_id}", response_model=Question)
def get_question(question_id: int):
    """
    Retrieve a single question by ID.

    Args:
        question_id: The unique identifier of the question

    Returns:
        The question if found

    Raises:
        HTTPException 404: If the question doesn't exist
    """
    # Search for the question in our "database"
    for question in questions_db:
        if question["id"] == question_id:
            return question

    # If we get here, the question wasn't found
    # HTTPException returns an error response to the client
    raise HTTPException(  # type: ignore[arg-type]
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Question with id {question_id} not found"
    )


# ---- Create New Question ----
# POST requests typically include a body with the data to create.
# FastAPI automatically parses JSON body into our Pydantic model.

@app.post("/questions", response_model=Question, status_code=status.HTTP_201_CREATED)
def create_question(question: QuestionCreate):
    """
    Create a new question.

    Args:
        question: The question data (parsed from JSON body)

    Returns:
        The created question with its assigned ID

    Note:
        status_code=201 means "Created" - the standard response
        for successful POST requests that create a resource.
    """
    global next_id  # We need to modify the global counter

    # Create the new question with an ID
    new_question = {
        "id": next_id,
        "question": question.question,
        "answer": question.answer,
        "difficulty": question.difficulty
    }

    # Add to our "database"
    questions_db.append(new_question)

    # Increment the ID counter for next time
    next_id += 1

    return new_question


# -----------------------------------------------------------------------------
# RUNNING THE APPLICATION
# -----------------------------------------------------------------------------
# This block only runs if you execute this file directly:
#   python main.py
#
# It will NOT run when uvicorn imports this file:
#   uvicorn app.main:app
#
# The uvicorn command is preferred because it gives you more control
# (reload on changes, multiple workers, etc.)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
