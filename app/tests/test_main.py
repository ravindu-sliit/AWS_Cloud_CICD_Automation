# =============================================================================
# API TESTS
# =============================================================================
# These tests run automatically in the CI/CD pipeline.
# If any test fails, deployment is blocked.
# =============================================================================

from fastapi.testclient import TestClient
from app.main import app

# Create a test client
client = TestClient(app)


# -----------------------------------------------------------------------------
# Health Check Tests
# -----------------------------------------------------------------------------
def test_health_check():
    """Test that the health endpoint returns 200 OK"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_health_check_service_name():
    """Test that health check returns correct service name"""
    response = client.get("/health")
    assert response.json()["service"] == "assessment-api"


# -----------------------------------------------------------------------------
# Questions Endpoint Tests
# -----------------------------------------------------------------------------
def test_get_questions():
    """Test that we can retrieve all questions"""
    response = client.get("/questions")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_get_single_question():
    """Test that we can retrieve a single question by ID"""
    response = client.get("/questions/1")
    assert response.status_code == 200
    assert "question" in response.json()
    assert "answer" in response.json()


def test_get_nonexistent_question():
    """Test that requesting a non-existent question returns 404"""
    response = client.get("/questions/9999")
    assert response.status_code == 404


def test_create_question():
    """Test that we can create a new question"""
    new_question = {
        "question": "What is the test question?",
        "answer": "Test answer",
        "difficulty": "easy"
    }
    response = client.post("/questions", json=new_question)
    assert response.status_code == 201
    assert response.json()["question"] == new_question["question"]
    assert "id" in response.json()  # Server should assign an ID


def test_create_question_missing_fields():
    """Test that creating a question without required fields returns 422"""
    incomplete_question = {
        "question": "Missing answer and difficulty"
    }
    response = client.post("/questions", json=incomplete_question)
    assert response.status_code == 422  # Validation error