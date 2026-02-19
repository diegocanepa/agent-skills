---
name: python
description: Python development with type hints, pythonic patterns, async/await, and modern best practices. Focus on clean, testable code following PEP standards.
---

# Python Skill

## Overview
Expert Python development focusing on modern best practices, type safety, clean code, and pythonic patterns. Always refer to `backend-coder.md` for general backend principles.

## Core Python Principles

### 1. Type Hints (Python 3.10+)
Always use type hints for better code clarity and IDE support.

```python
from typing import Optional, List, Dict, Union, Any
from dataclasses import dataclass

def process_user_data(
    user_id: int,
    email: str,
    metadata: Optional[Dict[str, Any]] = None
) -> Dict[str, str]:
    """Process user data and return formatted result."""
    if metadata is None:
        metadata = {}
    
    return {
        "id": str(user_id),
        "email": email.lower(),
        "status": "active"
    }

# Python 3.10+ - Use union operator
def find_user(user_id: int) -> User | None:
    return user_repository.find_by_id(user_id)
```

### 2. Dataclasses and Pydantic
Use dataclasses for simple data containers, Pydantic for validation.

```python
from dataclasses import dataclass, field
from datetime import datetime
from pydantic import BaseModel, EmailStr, validator

# Dataclass for simple data structures
@dataclass
class User:
    id: int
    email: str
    created_at: datetime = field(default_factory=datetime.now)
    metadata: Dict[str, Any] = field(default_factory=dict)

# Pydantic for validation and API models
class UserCreateRequest(BaseModel):
    email: EmailStr
    username: str
    age: int
    
    @validator('username')
    def validate_username(cls, v):
        if len(v) < 3:
            raise ValueError('Username must be at least 3 characters')
        return v.lower()
    
    @validator('age')
    def validate_age(cls, v):
        if v < 18:
            raise ValueError('User must be 18 or older')
        return v
```

### 3. Pythonic Patterns

#### List Comprehensions
```python
# Good: Comprehensions for simple transformations
active_users = [user for user in users if user.is_active]
user_emails = [user.email for user in users]
user_map = {user.id: user for user in users}

# Bad: Unnecessary loops
active_users = []
for user in users:
    if user.is_active:
        active_users.append(user)
```

#### Context Managers
```python
# Good: Always use context managers for resources
from contextlib import contextmanager

@contextmanager
def database_transaction(connection):
    try:
        yield connection
        connection.commit()
    except Exception:
        connection.rollback()
        raise
    finally:
        connection.close()

# Usage
with database_transaction(db_connection) as conn:
    conn.execute("INSERT INTO users ...")
```

#### Generators for Memory Efficiency
```python
# Good: Generator for large datasets
def read_large_file(file_path: str):
    with open(file_path, 'r') as file:
        for line in file:
            yield line.strip()

# Good: Generator expression
user_ids = (user.id for user in users if user.is_active)

# Bad: Load everything into memory
def read_large_file(file_path: str) -> List[str]:
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]  # Memory intensive
```

### 4. Async/Await (asyncio)
Use async for I/O-bound operations.

```python
import asyncio
from typing import List
import httpx

async def fetch_user(client: httpx.AsyncClient, user_id: int) -> Dict:
    response = await client.get(f"/users/{user_id}")
    return response.json()

async def fetch_multiple_users(user_ids: List[int]) -> List[Dict]:
    async with httpx.AsyncClient() as client:
        tasks = [fetch_user(client, user_id) for user_id in user_ids]
        return await asyncio.gather(*tasks)

# Run async code
async def main():
    users = await fetch_multiple_users([1, 2, 3, 4, 5])
    print(users)

if __name__ == "__main__":
    asyncio.run(main())
```

### 5. Error Handling

#### Custom Exceptions
```python
class ApplicationError(Exception):
    """Base exception for application errors."""
    pass

class UserNotFoundError(ApplicationError):
    def __init__(self, user_id: int):
        self.user_id = user_id
        super().__init__(f"User with ID {user_id} not found")

class ValidationError(ApplicationError):
    def __init__(self, field: str, message: str):
        self.field = field
        super().__init__(f"Validation error on {field}: {message}")

# Usage
def get_user(user_id: int) -> User:
    user = user_repository.find_by_id(user_id)
    if not user:
        raise UserNotFoundError(user_id)
    return user
```

#### Error Handling Best Practices
```python
# Good: Specific exception handling
try:
    user = get_user(user_id)
    result = process_user(user)
except UserNotFoundError as e:
    logger.warning(f"User not found: {e.user_id}")
    return None
except ValidationError as e:
    logger.error(f"Validation failed: {e.field} - {e}")
    raise
except Exception as e:
    logger.exception("Unexpected error occurred")
    raise

# Bad: Catching everything
try:
    user = get_user(user_id)
    result = process_user(user)
except:  # Never do this
    pass
```

### 6. Dependency Injection with Protocols

```python
from typing import Protocol
from abc import abstractmethod

# Define protocol (interface)
class UserRepository(Protocol):
    @abstractmethod
    def find_by_id(self, user_id: int) -> User | None:
        ...
    
    @abstractmethod
    def save(self, user: User) -> User:
        ...

# Implementations
class PostgresUserRepository:
    def __init__(self, db_connection):
        self.db = db_connection
    
    def find_by_id(self, user_id: int) -> User | None:
        # PostgreSQL implementation
        pass
    
    def save(self, user: User) -> User:
        # PostgreSQL implementation
        pass

# Service with dependency injection
class UserService:
    def __init__(
        self,
        repository: UserRepository,
        email_service: EmailService,
        logger: logging.Logger
    ):
        self.repository = repository
        self.email_service = email_service
        self.logger = logger
    
    def create_user(self, email: str, username: str) -> User:
        user = User(email=email, username=username)
        saved_user = self.repository.save(user)
        self.email_service.send_welcome_email(saved_user)
        self.logger.info(f"User created: {saved_user.id}")
        return saved_user
```

### 7. Testing with pytest

```python
import pytest
from unittest.mock import Mock, patch

# Fixtures
@pytest.fixture
def user_repository():
    return Mock(spec=UserRepository)

@pytest.fixture
def email_service():
    return Mock(spec=EmailService)

@pytest.fixture
def user_service(user_repository, email_service):
    return UserService(
        repository=user_repository,
        email_service=email_service,
        logger=Mock()
    )

# Test cases
def test_create_user_success(user_service, user_repository, email_service):
    # Arrange
    expected_user = User(id=1, email="test@example.com", username="testuser")
    user_repository.save.return_value = expected_user
    
    # Act
    result = user_service.create_user("test@example.com", "testuser")
    
    # Assert
    assert result == expected_user
    user_repository.save.assert_called_once()
    email_service.send_welcome_email.assert_called_once_with(expected_user)

def test_create_user_validation_error(user_service):
    # Test with invalid data
    with pytest.raises(ValidationError) as exc_info:
        user_service.create_user("invalid-email", "ab")
    
    assert "email" in str(exc_info.value).lower()

# Parametrized tests
@pytest.mark.parametrize("email,username,should_pass", [
    ("valid@example.com", "validuser", True),
    ("invalid-email", "user", False),
    ("test@test.com", "ab", False),
])
def test_user_validation(email, username, should_pass):
    if should_pass:
        user = UserCreateRequest(email=email, username=username, age=25)
        assert user.email == email
    else:
        with pytest.raises(ValidationError):
            UserCreateRequest(email=email, username=username, age=25)

# Async tests
@pytest.mark.asyncio
async def test_fetch_users():
    users = await fetch_multiple_users([1, 2, 3])
    assert len(users) == 3
```

### 8. Code Organization

```
project/
├── src/
│   ├── domain/
│   │   ├── __init__.py
│   │   ├── entities.py          # Domain entities
│   │   └── value_objects.py     # Value objects
│   ├── application/
│   │   ├── __init__.py
│   │   ├── services.py          # Business logic
│   │   └── use_cases.py         # Use cases
│   ├── infrastructure/
│   │   ├── __init__.py
│   │   ├── repositories.py      # Data access
│   │   ├── external_apis.py     # External integrations
│   │   └── database.py          # DB connection
│   └── interfaces/
│       ├── __init__.py
│       ├── api/
│       │   ├── __init__.py
│       │   ├── routes.py        # API routes
│       │   └── schemas.py       # Request/response models
│       └── cli/
│           └── commands.py      # CLI commands
├── tests/
│   ├── __init__.py
│   ├── unit/
│   ├── integration/
│   └── conftest.py              # pytest fixtures
├── requirements.txt
├── requirements-dev.txt
├── pyproject.toml
└── .env.example
```

### 9. Environment and Configuration

```python
from pydantic_settings import BaseSettings
from functools import lru_cache

class Settings(BaseSettings):
    database_url: str
    api_key: str
    debug: bool = False
    log_level: str = "INFO"
    redis_url: str | None = None
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

@lru_cache()
def get_settings() -> Settings:
    return Settings()

# Usage
settings = get_settings()
print(settings.database_url)
```

### 10. Logging

```python
import logging
import sys
from pythonjsonlogger import jsonlogger

def setup_logging(log_level: str = "INFO"):
    logger = logging.getLogger()
    logger.setLevel(log_level)
    
    handler = logging.StreamHandler(sys.stdout)
    formatter = jsonlogger.JsonFormatter(
        '%(asctime)s %(name)s %(levelname)s %(message)s'
    )
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    
    return logger

# Usage
logger = setup_logging()

def process_order(order_id: int):
    logger.info("Processing order", extra={
        "order_id": order_id,
        "action": "process"
    })
    try:
        result = perform_processing(order_id)
        logger.info("Order processed successfully", extra={
            "order_id": order_id,
            "result": result
        })
    except Exception as e:
        logger.error("Order processing failed", extra={
            "order_id": order_id,
            "error": str(e)
        }, exc_info=True)
        raise
```

### 11. Performance Optimization

```python
from functools import lru_cache
import asyncio

# Caching expensive computations
@lru_cache(maxsize=128)
def expensive_computation(n: int) -> int:
    return sum(i * i for i in range(n))

# Batch processing
async def batch_process_users(user_ids: List[int], batch_size: int = 100):
    for i in range(0, len(user_ids), batch_size):
        batch = user_ids[i:i + batch_size]
        await process_batch(batch)
        await asyncio.sleep(0.1)  # Rate limiting

# Use slots for memory efficiency
class User:
    __slots__ = ['id', 'email', 'username']
    
    def __init__(self, id: int, email: str, username: str):
        self.id = id
        self.email = email
        self.username = username
```

## Python-Specific Tools

### Essential Libraries
- **FastAPI/Flask**: Web frameworks
- **SQLAlchemy**: ORM for databases
- **Pydantic**: Data validation
- **pytest**: Testing framework
- **httpx**: Async HTTP client
- **structlog/python-json-logger**: Structured logging
- **ruff**: Fast linter and formatter
- **mypy**: Static type checking

### Code Quality Tools

```toml
# pyproject.toml
[tool.ruff]
line-length = 100
target-version = "py310"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "W", "B", "C90"]
ignore = []

[tool.mypy]
python_version = "3.10"
strict = true
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_functions = "test_*"
addopts = "-v --cov=src --cov-report=term-missing"
```

## Quick Checklist (Python-Specific)

Before committing Python code:
- [ ] All functions have type hints
- [ ] Used pythonic patterns (comprehensions, context managers)
- [ ] No mutable default arguments
- [ ] Proper exception handling with custom exceptions
- [ ] Tests written with pytest
- [ ] Code formatted with ruff/black
- [ ] Type checked with mypy
- [ ] No unused imports
- [ ] Docstrings for public APIs (Google or NumPy style)
- [ ] Environment variables managed properly

## Anti-Patterns to Avoid (Python)

1. **Mutable Default Arguments**: Never use `def func(items=[])`
2. **Bare Except**: Never use `except:` without specific exception
3. **Global Variables**: Avoid global state
4. **Not Using Type Hints**: Always annotate function signatures
5. **Ignoring PEP 8**: Follow Python style guidelines
6. **Not Using Virtual Environments**: Always use venv/poetry
7. **Circular Imports**: Restructure to avoid
8. **Using `import *`**: Explicit imports only

## References

- PEP 8 – Style Guide for Python Code
- PEP 484 – Type Hints
- PEP 585 – Type Hinting Generics in Standard Collections
- Python's official documentation
- Real Python tutorials
- Effective Python by Brett Slatkin
