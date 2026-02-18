---
name: backend-coder
description: Expert backend development following SOLID principles, design patterns, type-safety, and test-driven workflows. Build scalable, maintainable systems with atomic functions and clean architecture.
---

# Backend Coder Skill

## Overview
Expert-level backend development skill focused on writing clean, scalable, and maintainable code following industry best practices and SOLID principles.

## Work Patterns

1. **Impact Analysis**: Before editing, use `ls` and `read_file` to understand the dependencies of the affected module.
2. **Type-Safety First**: Prioritize strong typing and compile-time validation. Avoid `any`, `interface{}` or dynamic types when possible.
3. **Test-Driven Development**:
   - Always create or modify tests when adding or changing existing code.
   - Write tests before or alongside implementation (not after).
   - Ensure test coverage for new functionality and edge cases.
4. **Verification Cycle**:
   - Always run local tests after coding.
   - If tests fail, analyze the stack trace and fix autonomously.
   - Verify that existing tests are not broken before adding new functionality.

## Core Principles

### 1. Code Quality Standards
- **English Only**: All code, comments, variables, functions, and documentation must be in English
- **Minimal Documentation**: Document only when necessary - code should be self-explanatory
- **Atomic Functions**: Each function should do one thing and do it well (Single Responsibility Principle)

### 2. SOLID Principles

#### Single Responsibility Principle (SRP)
- Each class/module should have only one reason to change
- Functions should perform a single, well-defined task
```python
# Good
def calculate_total_price(items):
    return sum(item.price for item in items)

def apply_discount(total, discount_rate):
    return total * (1 - discount_rate)

# Bad
def process_order(items, discount_rate):
    total = sum(item.price for item in items)
    discounted = total * (1 - discount_rate)
    send_email_confirmation()
    update_inventory()
    # Too many responsibilities!
```

#### Open/Closed Principle (OCP)
- Open for extension, closed for modification
- Use interfaces, abstract classes, and dependency injection

#### Liskov Substitution Principle (LSP)
- Derived classes must be substitutable for their base classes
- Maintain behavioral compatibility

#### Interface Segregation Principle (ISP)
- Clients should not depend on interfaces they don't use
- Create specific, focused interfaces

#### Dependency Inversion Principle (DIP)
- Depend on abstractions, not concretions
- High-level modules should not depend on low-level modules

### 3. Design Patterns for Scalability

#### Dependency Injection
```python
# Good: Dependencies injected
class OrderService:
    def __init__(self, repository, email_service, logger):
        self.repository = repository
        self.email_service = email_service
        self.logger = logger
    
    def create_order(self, order_data):
        order = self.repository.save(order_data)
        self.email_service.send_confirmation(order)
        self.logger.info(f"Order {order.id} created")
        return order

# Bad: Hard-coded dependencies
class OrderService:
    def __init__(self):
        self.repository = DatabaseRepository()  # Tightly coupled
        self.email_service = SmtpEmailService()  # Hard to test
```

#### State Pattern
```python
from abc import ABC, abstractmethod

class OrderState(ABC):
    @abstractmethod
    def process(self, order):
        pass

class PendingState(OrderState):
    def process(self, order):
        order.set_state(ProcessingState())
        return "Order is now processing"

class ProcessingState(OrderState):
    def process(self, order):
        order.set_state(ShippedState())
        return "Order has been shipped"

class Order:
    def __init__(self):
        self._state = PendingState()
    
    def set_state(self, state):
        self._state = state
    
    def process(self):
        return self._state.process(self)
```

#### Strategy Pattern
```python
from abc import ABC, abstractmethod

class PaymentStrategy(ABC):
    @abstractmethod
    def process_payment(self, amount):
        pass

class CreditCardPayment(PaymentStrategy):
    def process_payment(self, amount):
        # Process credit card payment
        pass

class PayPalPayment(PaymentStrategy):
    def process_payment(self, amount):
        # Process PayPal payment
        pass

class PaymentProcessor:
    def __init__(self, strategy: PaymentStrategy):
        self.strategy = strategy
    
    def process(self, amount):
        return self.strategy.process_payment(amount)
```

#### Repository Pattern
```python
from abc import ABC, abstractmethod

class Repository(ABC):
    @abstractmethod
    def find_by_id(self, id):
        pass
    
    @abstractmethod
    def save(self, entity):
        pass
    
    @abstractmethod
    def delete(self, id):
        pass

class UserRepository(Repository):
    def __init__(self, db_connection):
        self.db = db_connection
    
    def find_by_id(self, id):
        return self.db.query("SELECT * FROM users WHERE id = ?", id)
    
    def save(self, user):
        return self.db.execute("INSERT INTO users ...", user)
    
    def delete(self, id):
        return self.db.execute("DELETE FROM users WHERE id = ?", id)
```

#### Factory Pattern
```python
class DatabaseFactory:
    @staticmethod
    def create_connection(db_type, config):
        if db_type == "postgres":
            return PostgresConnection(config)
        elif db_type == "mysql":
            return MySQLConnection(config)
        elif db_type == "mongodb":
            return MongoDBConnection(config)
        raise ValueError(f"Unknown database type: {db_type}")
```

### 4. Architecture Patterns

#### Clean Architecture / Hexagonal Architecture
```
├── domain/          # Business logic, entities, value objects
├── application/     # Use cases, application services
├── infrastructure/  # External dependencies (DB, APIs, frameworks)
└── interfaces/      # Controllers, presenters, adapters
```

#### CQRS (Command Query Responsibility Segregation)
- Separate read and write operations
- Optimize each for its specific purpose

### 5. Best Practices

#### Error Handling
```python
# Good: Specific exceptions, clear error messages
class OrderNotFoundError(Exception):
    def __init__(self, order_id):
        super().__init__(f"Order with ID {order_id} not found")

def get_order(order_id):
    order = repository.find_by_id(order_id)
    if not order:
        raise OrderNotFoundError(order_id)
    return order

# Bad: Generic exceptions
def get_order(order_id):
    try:
        return repository.find_by_id(order_id)
    except:
        raise Exception("Error!")
```

#### Configuration Management
```python
# Good: Environment-based configuration
import os

class Config:
    DATABASE_URL = os.getenv("DATABASE_URL")
    API_KEY = os.getenv("API_KEY")
    DEBUG = os.getenv("DEBUG", "false").lower() == "true"

# Bad: Hard-coded values
DATABASE_URL = "postgres://localhost:5432/mydb"
API_KEY = "1234567890"
```

#### Logging
```python
# Good: Structured logging with appropriate levels
import logging

logger = logging.getLogger(__name__)

def process_payment(payment_data):
    logger.info("Processing payment", extra={"payment_id": payment_data.id})
    try:
        result = payment_gateway.charge(payment_data)
        logger.info("Payment processed successfully", extra={"payment_id": payment_data.id})
        return result
    except PaymentError as e:
        logger.error("Payment failed", extra={"payment_id": payment_data.id, "error": str(e)})
        raise
```

#### Type Hints (Python) / Strong Typing
```python
# Good: Clear type hints
from typing import List, Optional

def calculate_average(numbers: List[float]) -> float:
    return sum(numbers) / len(numbers)

def find_user(user_id: int) -> Optional[User]:
    return user_repository.find_by_id(user_id)
```

### 6. Testing Strategy
- Unit tests for business logic
- Integration tests for external dependencies
- Test coverage should focus on critical paths
- Use mocks and stubs for external dependencies

### 7. Code Organization
```
project/
├── src/
│   ├── domain/          # Core business logic
│   ├── application/     # Use cases
│   ├── infrastructure/  # External integrations
│   └── interfaces/      # API controllers, CLI
├── tests/
│   ├── unit/
│   ├── integration/
│   └── fixtures/
└── config/
```

### 8. Performance Considerations
- Use caching strategically
- Implement pagination for large datasets
- Use async/await for I/O-bound operations
- Database query optimization
- Connection pooling

### 9. Security Best Practices
- Input validation and sanitization
- Use parameterized queries (prevent SQL injection)
- Implement proper authentication and authorization
- Encrypt sensitive data
- Follow principle of least privilege

## Language-Specific Skills

When implementing backend code, refer to the language-specific skill:
- **Python**: See `skills/python/python.md`
- **Go**: See `skills/golang/golang.md`

## Quick Checklist

Before committing code, verify:
- [ ] All code is in English
- [ ] Functions are atomic and focused
- [ ] SOLID principles are followed
- [ ] Dependencies are injected, not hard-coded
- [ ] Appropriate design patterns are used
- [ ] Error handling is specific and meaningful
- [ ] Configuration is externalized
- [ ] Logging is present at key points
- [ ] Code is testable
- [ ] Security considerations are addressed

## Anti-Patterns to Avoid

1. **God Objects**: Classes that know too much or do too much
2. **Tight Coupling**: Direct dependencies between modules
3. **Magic Numbers/Strings**: Use named constants
4. **Premature Optimization**: Optimize when needed, not before
5. **Copy-Paste Programming**: Extract common logic into reusable functions
6. **Long Functions**: Keep functions short and focused
7. **Deep Nesting**: Flatten conditional logic
8. **Mixing Concerns**: Separate business logic from infrastructure