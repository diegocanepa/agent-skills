---
name: golang
description: Go development with idiomatic patterns, interfaces, concurrency, and error handling. Build performant, concurrent systems following Go best practices.
---

# Golang Skill

## Overview
Expert Go development focusing on idiomatic code, concurrency, interfaces, and performance. Always refer to `backend-coder.md` for general backend principles.

## Core Go Principles

### 1. Idiomatic Go Style

```go
// Good: Clear, simple naming
type UserRepository interface {
    FindByID(id int64) (*User, error)
    Save(user *User) error
    Delete(id int64) error
}

// Good: Short variable names in small scopes
func processUsers(users []User) error {
    for _, u := range users {
        if err := process(u); err != nil {
            return err
        }
    }
    return nil
}

// Bad: Verbose naming
type IUserRepositoryInterface interface {
    FindUserByIdentifier(identifier int64) (*User, error)
}
```

### 2. Error Handling

```go
import (
    "errors"
    "fmt"
)

// Custom errors
var (
    ErrUserNotFound = errors.New("user not found")
    ErrInvalidInput = errors.New("invalid input")
)

// Error with context
type ValidationError struct {
    Field   string
    Message string
}

func (e *ValidationError) Error() string {
    return fmt.Sprintf("validation error on %s: %s", e.Field, e.Message)
}

// Wrapping errors (Go 1.13+)
func GetUser(id int64) (*User, error) {
    user, err := repo.FindByID(id)
    if err != nil {
        return nil, fmt.Errorf("failed to get user %d: %w", id, err)
    }
    return user, nil
}

// Checking wrapped errors
func HandleError(err error) {
    if errors.Is(err, ErrUserNotFound) {
        // Handle user not found
    }
    
    var validationErr *ValidationError
    if errors.As(err, &validationErr) {
        // Handle validation error
        fmt.Printf("Field: %s, Message: %s\n", validationErr.Field, validationErr.Message)
    }
}

// Good: Always check errors
func processFile(path string) error {
    f, err := os.Open(path)
    if err != nil {
        return fmt.Errorf("failed to open file: %w", err)
    }
    defer f.Close()
    
    data, err := io.ReadAll(f)
    if err != nil {
        return fmt.Errorf("failed to read file: %w", err)
    }
    
    return process(data)
}

// Bad: Ignoring errors
func processFile(path string) {
    f, _ := os.Open(path)  // Never ignore errors
    defer f.Close()
}
```

### 3. Interfaces and Dependency Injection

```go
// Small, focused interfaces
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

type ReadWriter interface {
    Reader
    Writer
}

// Repository pattern
type UserRepository interface {
    FindByID(ctx context.Context, id int64) (*User, error)
    Save(ctx context.Context, user *User) error
    Delete(ctx context.Context, id int64) error
    List(ctx context.Context, limit, offset int) ([]User, error)
}

// Implementation
type postgresUserRepository struct {
    db *sql.DB
}

func NewPostgresUserRepository(db *sql.DB) UserRepository {
    return &postgresUserRepository{db: db}
}

func (r *postgresUserRepository) FindByID(ctx context.Context, id int64) (*User, error) {
    var user User
    query := "SELECT id, email, username FROM users WHERE id = $1"
    
    err := r.db.QueryRowContext(ctx, query, id).Scan(&user.ID, &user.Email, &user.Username)
    if err == sql.ErrNoRows {
        return nil, ErrUserNotFound
    }
    if err != nil {
        return nil, fmt.Errorf("failed to query user: %w", err)
    }
    
    return &user, nil
}

// Service with dependency injection
type UserService struct {
    repo   UserRepository
    logger *slog.Logger
}

func NewUserService(repo UserRepository, logger *slog.Logger) *UserService {
    return &UserService{
        repo:   repo,
        logger: logger,
    }
}

func (s *UserService) GetUser(ctx context.Context, id int64) (*User, error) {
    s.logger.Info("fetching user", "user_id", id)
    
    user, err := s.repo.FindByID(ctx, id)
    if err != nil {
        s.logger.Error("failed to fetch user", "user_id", id, "error", err)
        return nil, err
    }
    
    return user, nil
}
```

### 4. Structs and Methods

```go
// Good: Struct with constructor
type User struct {
    ID        int64
    Email     string
    Username  string
    CreatedAt time.Time
}

func NewUser(email, username string) *User {
    return &User{
        Email:     email,
        Username:  username,
        CreatedAt: time.Now(),
    }
}

// Value receiver for read-only methods
func (u User) FullName() string {
    return u.Username
}

// Pointer receiver for methods that modify
func (u *User) UpdateEmail(email string) error {
    if !isValidEmail(email) {
        return &ValidationError{Field: "email", Message: "invalid format"}
    }
    u.Email = email
    return nil
}

// Embedding for composition
type AuditedUser struct {
    User
    UpdatedAt time.Time
    UpdatedBy string
}

func (au *AuditedUser) Update(email string, updatedBy string) error {
    if err := au.UpdateEmail(email); err != nil {
        return err
    }
    au.UpdatedAt = time.Now()
    au.UpdatedBy = updatedBy
    return nil
}
```

### 5. Concurrency Patterns

#### Goroutines and Channels
```go
import "sync"

// Worker pool pattern
func processItems(items []Item, workerCount int) error {
    jobs := make(chan Item, len(items))
    results := make(chan error, len(items))
    
    // Start workers
    var wg sync.WaitGroup
    for i := 0; i < workerCount; i++ {
        wg.Add(1)
        go worker(jobs, results, &wg)
    }
    
    // Send jobs
    for _, item := range items {
        jobs <- item
    }
    close(jobs)
    
    // Wait for completion
    go func() {
        wg.Wait()
        close(results)
    }()
    
    // Collect results
    for err := range results {
        if err != nil {
            return err
        }
    }
    
    return nil
}

func worker(jobs <-chan Item, results chan<- error, wg *sync.WaitGroup) {
    defer wg.Done()
    for item := range jobs {
        results <- processItem(item)
    }
}

// Fan-out, fan-in pattern
func fetchMultipleUsers(ctx context.Context, ids []int64) ([]User, error) {
    results := make(chan *User, len(ids))
    errors := make(chan error, len(ids))
    
    var wg sync.WaitGroup
    for _, id := range ids {
        wg.Add(1)
        go func(id int64) {
            defer wg.Done()
            user, err := fetchUser(ctx, id)
            if err != nil {
                errors <- err
                return
            }
            results <- user
        }(id)
    }
    
    go func() {
        wg.Wait()
        close(results)
        close(errors)
    }()
    
    var users []User
    for user := range results {
        users = append(users, *user)
    }
    
    // Check for errors
    for err := range errors {
        if err != nil {
            return nil, err
        }
    }
    
    return users, nil
}

// Context-aware operations
func doWork(ctx context.Context) error {
    select {
    case <-ctx.Done():
        return ctx.Err()
    case <-time.After(5 * time.Second):
        // Do work
        return nil
    }
}
```

#### Sync Primitives
```go
import "sync"

// Mutex for shared state
type SafeCounter struct {
    mu    sync.RWMutex
    count map[string]int
}

func (c *SafeCounter) Increment(key string) {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.count[key]++
}

func (c *SafeCounter) Get(key string) int {
    c.mu.RLock()
    defer c.mu.RUnlock()
    return c.count[key]
}

// Once for one-time initialization
type Database struct {
    conn *sql.DB
}

var (
    db   *Database
    once sync.Once
)

func GetDatabase() *Database {
    once.Do(func() {
        conn, err := sql.Open("postgres", dsn)
        if err != nil {
            panic(err)
        }
        db = &Database{conn: conn}
    })
    return db
}
```

### 6. Testing

```go
import (
    "testing"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/mock"
)

// Table-driven tests
func TestCalculateTotal(t *testing.T) {
    tests := []struct {
        name     string
        items    []Item
        expected float64
        wantErr  bool
    }{
        {
            name:     "empty items",
            items:    []Item{},
            expected: 0,
            wantErr:  false,
        },
        {
            name: "single item",
            items: []Item{
                {Price: 10.0},
            },
            expected: 10.0,
            wantErr:  false,
        },
        {
            name: "multiple items",
            items: []Item{
                {Price: 10.0},
                {Price: 20.0},
            },
            expected: 30.0,
            wantErr:  false,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result, err := CalculateTotal(tt.items)
            if tt.wantErr {
                assert.Error(t, err)
            } else {
                assert.NoError(t, err)
                assert.Equal(t, tt.expected, result)
            }
        })
    }
}

// Mocking with testify
type MockUserRepository struct {
    mock.Mock
}

func (m *MockUserRepository) FindByID(ctx context.Context, id int64) (*User, error) {
    args := m.Called(ctx, id)
    if args.Get(0) == nil {
        return nil, args.Error(1)
    }
    return args.Get(0).(*User), args.Error(1)
}

func TestUserService_GetUser(t *testing.T) {
    mockRepo := new(MockUserRepository)
    logger := slog.Default()
    service := NewUserService(mockRepo, logger)
    
    expectedUser := &User{ID: 1, Email: "test@example.com"}
    mockRepo.On("FindByID", mock.Anything, int64(1)).Return(expectedUser, nil)
    
    user, err := service.GetUser(context.Background(), 1)
    
    assert.NoError(t, err)
    assert.Equal(t, expectedUser, user)
    mockRepo.AssertExpectations(t)
}

// Benchmarks
func BenchmarkCalculateTotal(b *testing.B) {
    items := []Item{
        {Price: 10.0},
        {Price: 20.0},
        {Price: 30.0},
    }
    
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        CalculateTotal(items)
    }
}
```

### 7. Configuration

```go
import (
    "github.com/caarlos0/env/v10"
    "github.com/joho/godotenv"
)

type Config struct {
    DatabaseURL string `env:"DATABASE_URL,required"`
    Port        int    `env:"PORT" envDefault:"8080"`
    LogLevel    string `env:"LOG_LEVEL" envDefault:"info"`
    Debug       bool   `env:"DEBUG" envDefault:"false"`
}

func LoadConfig() (*Config, error) {
    // Load .env file (optional in production)
    _ = godotenv.Load()
    
    cfg := &Config{}
    if err := env.Parse(cfg); err != nil {
        return nil, fmt.Errorf("failed to parse config: %w", err)
    }
    
    return cfg, nil
}
```

### 8. Logging (slog - Go 1.21+)

```go
import (
    "log/slog"
    "os"
)

func SetupLogger(level string) *slog.Logger {
    var logLevel slog.Level
    switch level {
    case "debug":
        logLevel = slog.LevelDebug
    case "info":
        logLevel = slog.LevelInfo
    case "warn":
        logLevel = slog.LevelWarn
    case "error":
        logLevel = slog.LevelError
    default:
        logLevel = slog.LevelInfo
    }
    
    handler := slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
        Level: logLevel,
    })
    
    return slog.New(handler)
}

// Usage with context
func ProcessOrder(ctx context.Context, orderID int64, logger *slog.Logger) error {
    logger.InfoContext(ctx, "processing order",
        slog.Int64("order_id", orderID),
        slog.String("action", "process"),
    )
    
    if err := doProcessing(orderID); err != nil {
        logger.ErrorContext(ctx, "order processing failed",
            slog.Int64("order_id", orderID),
            slog.String("error", err.Error()),
        )
        return err
    }
    
    logger.InfoContext(ctx, "order processed successfully",
        slog.Int64("order_id", orderID),
    )
    return nil
}
```

### 9. Project Structure

```
project/
├── cmd/
│   └── api/
│       └── main.go              # Application entry point
├── internal/
│   ├── domain/
│   │   ├── user.go             # Domain entities
│   │   └── order.go
│   ├── repository/
│   │   ├── user_repository.go  # Repository interfaces & implementations
│   │   └── postgres/
│   │       └── user.go
│   ├── service/
│   │   └── user_service.go     # Business logic
│   ├── handler/
│   │   └── http/
│   │       └── user_handler.go # HTTP handlers
│   └── config/
│       └── config.go           # Configuration
├── pkg/
│   └── logger/
│       └── logger.go           # Shared packages
├── test/
│   ├── integration/
│   └── fixtures/
├── go.mod
├── go.sum
├── Makefile
└── .env.example
```

### 10. HTTP Server (stdlib or chi/gin)

```go
import (
    "net/http"
    "github.com/go-chi/chi/v5"
    "github.com/go-chi/chi/v5/middleware"
)

type UserHandler struct {
    service *UserService
    logger  *slog.Logger
}

func NewUserHandler(service *UserService, logger *slog.Logger) *UserHandler {
    return &UserHandler{
        service: service,
        logger:  logger,
    }
}

func (h *UserHandler) GetUser(w http.ResponseWriter, r *http.Request) {
    idStr := chi.URLParam(r, "id")
    id, err := strconv.ParseInt(idStr, 10, 64)
    if err != nil {
        http.Error(w, "invalid user id", http.StatusBadRequest)
        return
    }
    
    user, err := h.service.GetUser(r.Context(), id)
    if errors.Is(err, ErrUserNotFound) {
        http.Error(w, "user not found", http.StatusNotFound)
        return
    }
    if err != nil {
        h.logger.Error("failed to get user", "error", err)
        http.Error(w, "internal server error", http.StatusInternalServerError)
        return
    }
    
    respondJSON(w, http.StatusOK, user)
}

func SetupRouter(handler *UserHandler) *chi.Mux {
    r := chi.NewRouter()
    
    r.Use(middleware.RequestID)
    r.Use(middleware.Logger)
    r.Use(middleware.Recoverer)
    r.Use(middleware.Timeout(60 * time.Second))
    
    r.Route("/api/v1", func(r chi.Router) {
        r.Get("/users/{id}", handler.GetUser)
        r.Post("/users", handler.CreateUser)
        r.Put("/users/{id}", handler.UpdateUser)
        r.Delete("/users/{id}", handler.DeleteUser)
    })
    
    return r
}
```

## Go-Specific Tools

### Essential Libraries
- **chi/gin**: HTTP routers
- **sqlx/pgx**: Database drivers
- **testify**: Testing utilities
- **godotenv**: Environment variables
- **slog**: Structured logging (Go 1.21+)
- **cobra**: CLI applications
- **viper**: Configuration management

### Code Quality Tools

```makefile
# Makefile
.PHONY: test lint fmt build

test:
	go test -v -race -cover ./...

lint:
	golangci-lint run ./...

fmt:
	gofmt -s -w .
	goimports -w .

build:
	go build -o bin/app cmd/api/main.go

run:
	go run cmd/api/main.go
```

## Quick Checklist (Go-Specific)

Before committing Go code:
- [ ] All errors are checked and handled
- [ ] Interfaces are small and focused
- [ ] Used `context.Context` for cancellation
- [ ] No race conditions (run with `-race` flag)
- [ ] Proper defer cleanup for resources
- [ ] Tests written with table-driven approach
- [ ] Code formatted with `gofmt`
- [ ] Linted with `golangci-lint`
- [ ] No goroutine leaks
- [ ] Exported functions have comments

## Anti-Patterns to Avoid (Go)

1. **Ignoring Errors**: Always handle errors explicitly
2. **Goroutine Leaks**: Always ensure goroutines terminate
3. **Not Using Context**: Use context for cancellation and timeouts
4. **Premature Concurrency**: Don't use goroutines unless needed
5. **Interface Pollution**: Keep interfaces small
6. **Not Using defer**: Always defer cleanup (Close, Unlock, etc.)
7. **Shared Memory Without Sync**: Use channels or proper synchronization
8. **Init Functions Abuse**: Avoid side effects in init()

## References

- Effective Go
- Go Code Review Comments
- The Go Programming Language (Donovan & Kernighan)
- Go Concurrency Patterns
- Standard library documentation
