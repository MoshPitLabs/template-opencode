# Backend Agents Analysis Report
**Date:** February 4, 2026  
**Scope:** Comprehensive analysis of backend-focused agents in `.opencode/agents/`

---

## Executive Summary

This analysis evaluates four backend-focused agents: **Java/Kotlin Backend** (2 variants), **Go Backend API**, **TypeScript Backend**, and **DevOps Infrastructure**. Overall, these agents demonstrate strong technical depth and production-ready guidance. Key findings:

- **Strengths:** Comprehensive coverage, modern best practices, strong security focus, excellent code examples
- **Gaps:** Missing microservices patterns, observability tooling, API gateway guidance, service mesh details
- **Recommendations:** Add cross-cutting concerns, enhance real-world scenarios, include troubleshooting guides

---

## Agent-by-Agent Analysis

### 1. Java/Kotlin Backend Agents

**Files Analyzed:**
- `java-kotlin-backend-opus45.md` (Claude Opus 4-5 model)
- `java-kotlin-backend-gpt52.md` (GPT-5.2 model)

#### Domain Coverage & Specialization (9/10)

**Strengths:**
- Comprehensive Spring ecosystem coverage (Boot, Data, Security, MVC/WebFlux)
- Excellent dependency management guidance (Maven/Gradle, BOMs, multi-module)
- Strong focus on testability (JUnit 5, Mockito, Testcontainers, Spring Boot testing slices)
- Modern Java/Kotlin features well-documented (Records, Sealed Classes, Coroutines, Data Classes)
- Clear transaction management and JPA optimization guidance

**Gaps:**
- **Microservices patterns:** Missing Spring Cloud (Config, Gateway, Circuit Breaker, Service Discovery)
- **Event-driven architecture:** No Spring Kafka, Spring AMQP, or event sourcing patterns
- **API Gateway patterns:** Missing guidance on implementing API composition, rate limiting at gateway level
- **Reactive programming depth:** WebFlux mentioned but limited Reactor patterns
- **Distributed tracing:** No OpenTelemetry, Zipkin, or Jaeger integration examples
- **gRPC integration:** Not covered despite being common for inter-service communication

#### Tool Permissions & Capabilities (8/10)

**Strengths:**
- Appropriate bash permissions for Maven/Gradle operations
- Clear separation between "allow" and "ask" permissions
- Version checking commands enabled

**Gaps:**
- No `docker` commands for local containerization testing
- Missing `kubectl` permissions for k8s-deployed Spring Boot apps debugging
- No JVM profiling tools access (jstat, jmap, jcmd)
- Could enable Spring Boot Actuator endpoint testing commands

#### Prompt Quality & Clarity (9/10)

**Strengths:**
- Clear persona definition ("Senior Developer with deep expertise")
- Well-structured principles (Leverage Ecosystem, Design for Maintainability, Testability, etc.)
- Excellent organization by topic (Language, Build Tools, Spring Core, Web Layer, etc.)
- Strong "Addressing Common Challenges" section

**Improvements Needed:**
- Add "When to Use This Agent" section (like TypeScript backend agent)
- Include decision trees (e.g., "Choose JPA vs JDBC vs R2DBC")
- Add anti-patterns section (what NOT to do)

#### Examples & Use Cases (9/10)

**Strengths:**
- Comprehensive REST controller example with proper validation
- Excellent Spring Data JPA repository patterns
- Service layer with transaction management well-demonstrated
- Global exception handler implementation included

**Missing:**
- **Kotlin-specific examples:** All examples are Java; need Kotlin coroutines + Spring examples
- **Reactive WebFlux example:** No Mono/Flux controller examples
- **Spring Security configuration example:** SecurityFilterChain not shown in code
- **Multi-module Gradle project structure:** Only mentioned, not shown
- **Testcontainers integration test example:** Mentioned but no code
- **Spring Boot Actuator custom endpoint:** Not demonstrated

#### Specific Improvement Recommendations

**1. Add Microservices Section**
```markdown
## Microservices Patterns (Spring Cloud)

### Service Discovery (Eureka/Consul)
- Client-side load balancing with Spring Cloud LoadBalancer
- Health checks and service registration
- Example: @EnableDiscoveryClient configuration

### API Gateway (Spring Cloud Gateway)
- Route configuration and predicates
- Filters (rate limiting, circuit breaker, retry)
- Example: RouteLocator bean configuration

### Distributed Configuration (Spring Cloud Config)
- Centralized configuration with refresh capabilities
- Example: @RefreshScope usage

### Circuit Breaker (Resilience4j)
- @CircuitBreaker, @Retry, @RateLimiter annotations
- Fallback strategies
- Monitoring circuit breaker states
```

**2. Add Kotlin-Specific Guidance**
```markdown
## Kotlin Best Practices for Spring Boot

### Coroutines with Spring WebFlux
```kotlin
@RestController
@RequestMapping("/api/v1/users")
class UserController(private val userService: UserService) {
    
    @GetMapping("/{id}")
    suspend fun getUserById(@PathVariable id: Long): ResponseEntity<UserResponse> {
        val user = userService.findUserById(id) // suspend function
        return ResponseEntity.ok(user)
    }
    
    @GetMapping("/search")
    fun searchUsers(@RequestParam query: String): Flow<UserResponse> {
        return userService.searchUsers(query) // returns Flow
    }
}
```

### Kotlin DSL for Configuration
```kotlin
@Configuration
class SecurityConfig {
    
    @Bean
    fun securityFilterChain(http: HttpSecurity): SecurityFilterChain {
        http {
            csrf { disable() }
            authorizeRequests {
                authorize("/api/public/**", permitAll)
                authorize("/api/admin/**", hasRole("ADMIN"))
                authorize(anyRequest, authenticated)
            }
            oauth2ResourceServer { jwt { } }
        }
        return http.build()
    }
}
```
```

**3. Add Observability Section**
```markdown
## Observability (Metrics, Tracing, Logging)

### Distributed Tracing with OpenTelemetry
```java
@Configuration
public class TracingConfig {
    
    @Bean
    public OpenTelemetry openTelemetry() {
        return AutoConfiguredOpenTelemetrySdk.initialize()
            .getOpenTelemetrySdk();
    }
}

// Custom spans in service layer
@Service
public class OrderService {
    private final Tracer tracer;
    
    public Order processOrder(OrderRequest request) {
        Span span = tracer.spanBuilder("processOrder")
            .setAttribute("order.id", request.getId())
            .setAttribute("order.total", request.getTotal())
            .startSpan();
        
        try (Scope scope = span.makeCurrent()) {
            // Business logic
            return orderRepository.save(order);
        } catch (Exception e) {
            span.recordException(e);
            span.setStatus(StatusCode.ERROR);
            throw e;
        } finally {
            span.end();
        }
    }
}
```

### Micrometer Custom Metrics
```java
@Service
public class MetricsService {
    private final Counter orderCounter;
    private final Timer orderProcessingTimer;
    
    public MetricsService(MeterRegistry registry) {
        this.orderCounter = Counter.builder("orders.created")
            .tag("type", "online")
            .register(registry);
            
        this.orderProcessingTimer = Timer.builder("order.processing.time")
            .register(registry);
    }
    
    public void processOrder(Order order) {
        orderProcessingTimer.record(() -> {
            // Processing logic
            orderCounter.increment();
        });
    }
}
```
```

**4. Add Troubleshooting Guide**
```markdown
## Common Issues & Troubleshooting

### LazyInitializationException
**Cause:** Accessing lazy-loaded entity relationships outside transaction boundary  
**Solution:** Use `@Transactional` on service methods, or fetch join in query  
**Example:**
```java
@Query("SELECT u FROM User u LEFT JOIN FETCH u.orders WHERE u.id = :id")
Optional<User> findByIdWithOrders(@Param("id") Long id);
```

### Slow Application Startup
**Diagnostic Steps:**
1. Enable startup logging: `spring.jpa.show-sql=true`, `-Ddebug=true`
2. Check auto-configuration report: `/actuator/conditions`
3. Profile startup: `java -XX:+UnlockDiagnosticVMOptions -XX:+LogCompilation -jar app.jar`

**Common Causes & Solutions:**
- Classpath scanning: Use explicit `@ComponentScan` basePackages
- JPA schema validation: Set `spring.jpa.hibernate.ddl-auto=none` in production
- Large number of beans: Use lazy initialization selectively
```

---

### 2. Go Backend API Agent

**File Analyzed:** `golang-backend-api.md`

#### Domain Coverage & Specialization (9/10)

**Strengths:**
- Excellent emphasis on standard library (`net/http`, Go 1.24+ ServeMux features)
- Strong concurrency guidance (goroutines, channels, context)
- Modern routing patterns with path parameters and method-specific routing
- SQLC preference clearly stated (type-safe SQL)
- Comprehensive security coverage (JWT, rate limiting, input validation)
- Good balance between stdlib and third-party libraries

**Gaps:**
- **gRPC implementation details:** Mentioned in tools but no detailed examples or patterns
- **GraphQL:** No mention despite growing adoption in Go APIs
- **WebSocket support:** Not covered for real-time features
- **API versioning strategies:** Mentioned briefly but no concrete patterns
- **Distributed systems:** No coverage of distributed tracing, circuit breakers, or retry strategies
- **Cloud-native patterns:** Missing 12-factor app guidance, health checks, graceful shutdown

#### Tool Permissions & Capabilities (9/10)

**Strengths:**
- Excellent Go toolchain coverage (`go build`, `go test`, `go mod`, `go fmt`, `go vet`)
- Linter support (`golangci-lint run`)
- Clear "*" ask policy for safety

**Improvements:**
- Consider allowing `go run` for script execution
- Add `docker build` permissions for containerization testing
- Consider `mockgen` for generating mocks in tests

#### Prompt Quality & Clarity (10/10)

**Strengths:**
- Outstanding principles section (Prioritize Standard Library, Simplicity, Explicit Error Handling)
- Excellent project structure guidance with clear directory conventions
- Very clear code style and naming conventions
- Strong emphasis on planning and correctness ("Leave no TODOs")
- Well-organized by concern (Routing, Handlers, Error Handling, Concurrency, etc.)

**Notable Excellence:**
- "Convention over complexity" approach aligns perfectly with Go philosophy
- Clear guidance on when to use frameworks vs stdlib
- Security-first mindset throughout

#### Examples & Use Cases (7/10)

**Strengths:**
- Clear handler patterns demonstrated
- Good middleware pattern explanation
- Error handling patterns well-articulated

**Missing:**
- **No concrete code examples** (unlike Java/TypeScript agents)
- **gRPC service implementation example** needed
- **SQLC-generated code usage example**
- **Testcontainers integration test example**
- **Context cancellation and timeout example**
- **Structured logging (slog) configuration and usage**

#### Specific Improvement Recommendations

**1. Add Comprehensive Code Examples Section**
```markdown
## Complete API Example (Standard Library)

### Project Structure
```
cmd/
  api/
    main.go
internal/
  handlers/
    user_handler.go
  middleware/
    auth.go
    logging.go
  models/
    user.go
  repository/
    user_repository.go
  service/
    user_service.go
```

### Main Application Setup
```go
package main

import (
    "context"
    "log/slog"
    "net/http"
    "os"
    "os/signal"
    "syscall"
    "time"
)

func main() {
    // Setup structured logger
    logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
        Level: slog.LevelInfo,
    }))
    slog.SetDefault(logger)
    
    // Initialize dependencies
    db, err := setupDatabase()
    if err != nil {
        slog.Error("failed to setup database", "error", err)
        os.Exit(1)
    }
    defer db.Close()
    
    // Setup router with enhanced ServeMux (Go 1.24+)
    mux := http.NewServeMux()
    
    // Register routes
    userHandler := handlers.NewUserHandler(db)
    mux.HandleFunc("GET /api/v1/users", userHandler.ListUsers)
    mux.HandleFunc("GET /api/v1/users/{id}", userHandler.GetUser)
    mux.HandleFunc("POST /api/v1/users", userHandler.CreateUser)
    mux.HandleFunc("PUT /api/v1/users/{id}", userHandler.UpdateUser)
    mux.HandleFunc("DELETE /api/v1/users/{id}", userHandler.DeleteUser)
    
    // Health check
    mux.HandleFunc("GET /health", func(w http.ResponseWriter, r *http.Request) {
        w.WriteHeader(http.StatusOK)
        w.Write([]byte(`{"status":"healthy"}`))
    })
    
    // Wrap with middleware chain
    handler := middleware.Chain(
        mux,
        middleware.RequestID,
        middleware.Logger(logger),
        middleware.Recovery,
        middleware.CORS,
    )
    
    // Create server
    srv := &http.Server{
        Addr:         ":8080",
        Handler:      handler,
        ReadTimeout:  15 * time.Second,
        WriteTimeout: 15 * time.Second,
        IdleTimeout:  60 * time.Second,
    }
    
    // Graceful shutdown
    go func() {
        slog.Info("server starting", "addr", srv.Addr)
        if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            slog.Error("server failed", "error", err)
            os.Exit(1)
        }
    }()
    
    // Wait for interrupt signal
    quit := make(chan os.Signal, 1)
    signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
    <-quit
    
    slog.Info("server shutting down")
    
    ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel()
    
    if err := srv.Shutdown(ctx); err != nil {
        slog.Error("server forced to shutdown", "error", err)
    }
    
    slog.Info("server stopped")
}
```

### Handler with Validation
```go
package handlers

import (
    "encoding/json"
    "net/http"
    "log/slog"
    "github.com/go-playground/validator/v10"
)

type CreateUserRequest struct {
    Email string `json:"email" validate:"required,email"`
    Name  string `json:"name" validate:"required,min=2,max=50"`
    Age   *int   `json:"age" validate:"omitempty,gte=18,lte=120"`
}

type UserHandler struct {
    userService *service.UserService
    validator   *validator.Validate
}

func NewUserHandler(db *sql.DB) *UserHandler {
    return &UserHandler{
        userService: service.NewUserService(repository.NewUserRepository(db)),
        validator:   validator.New(),
    }
}

func (h *UserHandler) CreateUser(w http.ResponseWriter, r *http.Request) {
    ctx := r.Context()
    
    // Limit request body size
    r.Body = http.MaxBytesReader(w, r.Body, 1048576) // 1MB
    
    var req CreateUserRequest
    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        respondError(w, http.StatusBadRequest, "invalid request body")
        return
    }
    
    // Validate
    if err := h.validator.Struct(req); err != nil {
        validationErrors := err.(validator.ValidationErrors)
        respondError(w, http.StatusBadRequest, formatValidationErrors(validationErrors))
        return
    }
    
    // Call service
    user, err := h.userService.CreateUser(ctx, req)
    if err != nil {
        slog.ErrorContext(ctx, "failed to create user", "error", err)
        respondError(w, http.StatusInternalServerError, "failed to create user")
        return
    }
    
    respondJSON(w, http.StatusCreated, user)
}

func (h *UserHandler) GetUser(w http.ResponseWriter, r *http.Request) {
    ctx := r.Context()
    userID := r.PathValue("id") // Go 1.24+ feature
    
    if userID == "" {
        respondError(w, http.StatusBadRequest, "user id required")
        return
    }
    
    user, err := h.userService.GetUserByID(ctx, userID)
    if err != nil {
        if errors.Is(err, service.ErrUserNotFound) {
            respondError(w, http.StatusNotFound, "user not found")
            return
        }
        slog.ErrorContext(ctx, "failed to get user", "error", err, "user_id", userID)
        respondError(w, http.StatusInternalServerError, "failed to get user")
        return
    }
    
    respondJSON(w, http.StatusOK, user)
}
```
```

**2. Add gRPC Implementation Example**
```markdown
## gRPC Service Implementation

### Proto Definition
```protobuf
syntax = "proto3";

package user.v1;

option go_package = "github.com/yourorg/yourapp/gen/user/v1";

service UserService {
  rpc GetUser(GetUserRequest) returns (GetUserResponse);
  rpc ListUsers(ListUsersRequest) returns (ListUsersResponse);
  rpc CreateUser(CreateUserRequest) returns (CreateUserResponse);
}

message GetUserRequest {
  string id = 1;
}

message GetUserResponse {
  User user = 1;
}

message User {
  string id = 1;
  string email = 2;
  string name = 3;
  google.protobuf.Timestamp created_at = 4;
}
```

### Server Implementation
```go
package grpc

import (
    "context"
    "google.golang.org/grpc"
    "google.golang.org/grpc/codes"
    "google.golang.org/grpc/status"
    userv1 "github.com/yourorg/yourapp/gen/user/v1"
    "github.com/yourorg/yourapp/internal/service"
)

type UserServer struct {
    userv1.UnimplementedUserServiceServer
    userService *service.UserService
}

func NewUserServer(userService *service.UserService) *UserServer {
    return &UserServer{userService: userService}
}

func (s *UserServer) GetUser(ctx context.Context, req *userv1.GetUserRequest) (*userv1.GetUserResponse, error) {
    if req.Id == "" {
        return nil, status.Error(codes.InvalidArgument, "user id required")
    }
    
    user, err := s.userService.GetUserByID(ctx, req.Id)
    if err != nil {
        if errors.Is(err, service.ErrUserNotFound) {
            return nil, status.Error(codes.NotFound, "user not found")
        }
        return nil, status.Error(codes.Internal, "failed to get user")
    }
    
    return &userv1.GetUserResponse{
        User: &userv1.User{
            Id:    user.ID,
            Email: user.Email,
            Name:  user.Name,
            CreatedAt: timestamppb.New(user.CreatedAt),
        },
    }, nil
}
```
```

**3. Add Distributed Systems Patterns**
```markdown
## Distributed Systems Patterns

### Circuit Breaker with Context
```go
package circuitbreaker

import (
    "context"
    "errors"
    "sync"
    "time"
)

type State int

const (
    StateClosed State = iota
    StateOpen
    StateHalfOpen
)

type CircuitBreaker struct {
    maxFailures  int
    timeout      time.Duration
    state        State
    failures     int
    lastFailTime time.Time
    mu           sync.RWMutex
}

func New(maxFailures int, timeout time.Duration) *CircuitBreaker {
    return &CircuitBreaker{
        maxFailures: maxFailures,
        timeout:     timeout,
        state:       StateClosed,
    }
}

var ErrCircuitOpen = errors.New("circuit breaker is open")

func (cb *CircuitBreaker) Call(ctx context.Context, fn func(context.Context) error) error {
    cb.mu.RLock()
    state := cb.state
    cb.mu.RUnlock()
    
    if state == StateOpen {
        if time.Since(cb.lastFailTime) > cb.timeout {
            cb.setState(StateHalfOpen)
        } else {
            return ErrCircuitOpen
        }
    }
    
    err := fn(ctx)
    
    cb.mu.Lock()
    defer cb.mu.Unlock()
    
    if err != nil {
        cb.failures++
        cb.lastFailTime = time.Now()
        
        if cb.failures >= cb.maxFailures {
            cb.state = StateOpen
        }
        return err
    }
    
    // Success
    if cb.state == StateHalfOpen {
        cb.state = StateClosed
    }
    cb.failures = 0
    return nil
}
```

### Retry with Exponential Backoff
```go
package retry

import (
    "context"
    "errors"
    "math"
    "time"
)

type Config struct {
    MaxAttempts  int
    InitialDelay time.Duration
    MaxDelay     time.Duration
    Multiplier   float64
}

func WithBackoff(ctx context.Context, cfg Config, fn func(context.Context) error) error {
    var lastErr error
    
    for attempt := 0; attempt < cfg.MaxAttempts; attempt++ {
        if err := ctx.Err(); err != nil {
            return err // Context cancelled/deadline exceeded
        }
        
        lastErr = fn(ctx)
        if lastErr == nil {
            return nil
        }
        
        if attempt < cfg.MaxAttempts-1 {
            delay := time.Duration(float64(cfg.InitialDelay) * math.Pow(cfg.Multiplier, float64(attempt)))
            if delay > cfg.MaxDelay {
                delay = cfg.MaxDelay
            }
            
            select {
            case <-time.After(delay):
            case <-ctx.Done():
                return ctx.Err()
            }
        }
    }
    
    return lastErr
}
```
```

**4. Add Testing Examples**
```markdown
## Testing Examples

### Table-Driven Unit Tests
```go
package service_test

import (
    "context"
    "testing"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/require"
)

func TestUserService_CreateUser(t *testing.T) {
    tests := []struct {
        name        string
        input       service.CreateUserInput
        setupMock   func(*repository.MockUserRepository)
        wantErr     bool
        expectedErr error
    }{
        {
            name: "success",
            input: service.CreateUserInput{
                Email: "test@example.com",
                Name:  "Test User",
            },
            setupMock: func(m *repository.MockUserRepository) {
                m.On("FindByEmail", mock.Anything, "test@example.com").
                    Return(nil, repository.ErrNotFound)
                m.On("Create", mock.Anything, mock.Anything).
                    Return(&models.User{ID: "123", Email: "test@example.com"}, nil)
            },
            wantErr: false,
        },
        {
            name: "user already exists",
            input: service.CreateUserInput{
                Email: "existing@example.com",
                Name:  "Test User",
            },
            setupMock: func(m *repository.MockUserRepository) {
                m.On("FindByEmail", mock.Anything, "existing@example.com").
                    Return(&models.User{ID: "456"}, nil)
            },
            wantErr:     true,
            expectedErr: service.ErrUserAlreadyExists,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            mockRepo := new(repository.MockUserRepository)
            tt.setupMock(mockRepo)
            
            svc := service.NewUserService(mockRepo)
            
            user, err := svc.CreateUser(context.Background(), tt.input)
            
            if tt.wantErr {
                require.Error(t, err)
                if tt.expectedErr != nil {
                    assert.ErrorIs(t, err, tt.expectedErr)
                }
                assert.Nil(t, user)
            } else {
                require.NoError(t, err)
                assert.NotNil(t, user)
                assert.Equal(t, tt.input.Email, user.Email)
            }
            
            mockRepo.AssertExpectations(t)
        })
    }
}
```

### Integration Tests with Testcontainers
```go
package integration_test

import (
    "context"
    "database/sql"
    "testing"
    "github.com/testcontainers/testcontainers-go"
    "github.com/testcontainers/testcontainers-go/wait"
    _ "github.com/lib/pq"
)

func setupTestDB(t *testing.T) (*sql.DB, func()) {
    ctx := context.Background()
    
    req := testcontainers.ContainerRequest{
        Image:        "postgres:16-alpine",
        ExposedPorts: []string{"5432/tcp"},
        Env: map[string]string{
            "POSTGRES_USER":     "test",
            "POSTGRES_PASSWORD": "test",
            "POSTGRES_DB":       "testdb",
        },
        WaitingFor: wait.ForListeningPort("5432/tcp"),
    }
    
    container, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
        ContainerRequest: req,
        Started:          true,
    })
    require.NoError(t, err)
    
    host, _ := container.Host(ctx)
    port, _ := container.MappedPort(ctx, "5432")
    
    dsn := fmt.Sprintf("postgres://test:test@%s:%s/testdb?sslmode=disable", host, port.Port())
    db, err := sql.Open("postgres", dsn)
    require.NoError(t, err)
    
    // Run migrations
    runMigrations(t, db)
    
    cleanup := func() {
        db.Close()
        container.Terminate(ctx)
    }
    
    return db, cleanup
}

func TestUserRepository_Integration(t *testing.T) {
    db, cleanup := setupTestDB(t)
    defer cleanup()
    
    repo := repository.NewUserRepository(db)
    ctx := context.Background()
    
    // Test Create
    user, err := repo.Create(ctx, &models.User{
        Email: "test@example.com",
        Name:  "Test User",
    })
    require.NoError(t, err)
    assert.NotEmpty(t, user.ID)
    
    // Test FindByID
    found, err := repo.FindByID(ctx, user.ID)
    require.NoError(t, err)
    assert.Equal(t, user.Email, found.Email)
}
```
```

---

### 3. TypeScript Backend Agent

**File Analyzed:** `typescript-backend.md`

#### Domain Coverage & Specialization (10/10)

**Strengths:**
- **Outstanding breadth:** Express, Fastify, NestJS, Hono framework coverage
- **Excellent ORM coverage:** Prisma, Drizzle, TypeORM with detailed patterns
- **Comprehensive validation:** Zod patterns are exceptionally well-documented
- **Strong authentication:** JWT implementation with proper typing
- **Testing excellence:** Jest/Vitest unit tests + Supertest integration tests
- **Performance focus:** Redis caching with decorators
- **Production-ready:** Environment validation with Zod, structured logging with Pino

**Minor Gaps:**
- GraphQL implementation not covered (though tRPC mentioned)
- WebSocket/real-time communication patterns missing
- Message queues (RabbitMQ, Kafka) not addressed
- Distributed tracing setup could be more detailed

#### Tool Permissions & Capabilities (7/10)

**Notable Issue:**
- **No explicit bash permissions defined** (other agents have this)
- Should add permissions for:
  - `npm test*`, `npm run build`, `npm run lint`
  - `pnpm test*`, `pnpm build` (modern package manager)
  - `docker build`, `docker compose up` for local development

#### Prompt Quality & Clarity (10/10)

**Exceptional Strengths:**
- **Outstanding "When to Use This Agent" section** with context examples (should be model for others)
- Clear core expertise areas upfront
- Excellent use of progressive complexity (simple → advanced patterns)
- Best practices checklist at the end is extremely valuable
- Strong emphasis on type safety throughout

#### Examples & Use Cases (10/10)

**Exceptional Strengths:**
- **Most comprehensive code examples** of all backend agents
- Express, Fastify, AND NestJS patterns shown
- Multiple ORM examples (Prisma, Drizzle)
- Advanced Zod patterns including discriminated unions
- Complete authentication flow with middleware
- Caching decorator pattern demonstrated
- Integration testing with actual test code
- Production configuration with type-safe env parsing

**Gold Standard:**
This agent sets the bar for what code examples should look like across all agents.

#### Specific Improvement Recommendations

**1. Add GraphQL Implementation**
```markdown
## GraphQL with TypeScript

### Apollo Server with Express
```typescript
import { ApolloServer } from '@apollo/server';
import { expressMiddleware } from '@apollo/server/express4';
import { buildSchema } from 'type-graphql';

// Resolver with TypeGraphQL
@Resolver(User)
class UserResolver {
  @Query(() => User, { nullable: true })
  async user(@Arg('id') id: string): Promise<User | null> {
    return await userRepository.findById(id);
  }
  
  @Query(() => [User])
  async users(
    @Arg('limit', { defaultValue: 10 }) limit: number,
    @Arg('offset', { defaultValue: 0 }) offset: number
  ): Promise<User[]> {
    return await userRepository.findMany({ limit, offset });
  }
  
  @Mutation(() => User)
  @UseMiddleware(Authenticated)
  async createUser(@Arg('input') input: CreateUserInput): Promise<User> {
    return await userService.create(input);
  }
  
  @FieldResolver(() => [Post])
  async posts(@Root() user: User): Promise<Post[]> {
    return await postRepository.findByAuthorId(user.id);
  }
}

// Setup
const schema = await buildSchema({
  resolvers: [UserResolver],
  validate: true,
});

const server = new ApolloServer({ schema });
await server.start();

app.use('/graphql', express.json(), expressMiddleware(server, {
  context: async ({ req }) => ({ user: req.user }),
}));
```
```

**2. Add Real-Time Communication**
```markdown
## WebSocket & Server-Sent Events

### Socket.io with TypeScript
```typescript
import { Server } from 'socket.io';
import { z } from 'zod';

// Event schemas
const messageSchema = z.object({
  room: z.string(),
  content: z.string().min(1).max(500),
});

const joinRoomSchema = z.object({
  roomId: z.string(),
});

type MessagePayload = z.infer<typeof messageSchema>;
type JoinRoomPayload = z.infer<typeof joinRoomSchema>;

// Type-safe event definitions
interface ServerToClientEvents {
  message: (data: { from: string; content: string; timestamp: Date }) => void;
  userJoined: (data: { userId: string; username: string }) => void;
  userLeft: (data: { userId: string }) => void;
}

interface ClientToServerEvents {
  sendMessage: (data: MessagePayload, callback: (response: { success: boolean }) => void) => void;
  joinRoom: (data: JoinRoomPayload) => void;
  leaveRoom: (data: { roomId: string }) => void;
}

interface SocketData {
  userId: string;
  username: string;
}

// Setup
const io = new Server<ClientToServerEvents, ServerToClientEvents, {}, SocketData>(httpServer, {
  cors: { origin: process.env.CORS_ORIGIN },
});

// Authentication middleware
io.use(async (socket, next) => {
  try {
    const token = socket.handshake.auth.token;
    const user = await AuthService.verifyToken(token);
    socket.data = { userId: user.id, username: user.name };
    next();
  } catch (error) {
    next(new Error('Authentication failed'));
  }
});

// Connection handler
io.on('connection', (socket) => {
  console.log(`User connected: ${socket.data.username}`);
  
  socket.on('joinRoom', async (data) => {
    const validated = joinRoomSchema.parse(data);
    await socket.join(validated.roomId);
    
    io.to(validated.roomId).emit('userJoined', {
      userId: socket.data.userId,
      username: socket.data.username,
    });
  });
  
  socket.on('sendMessage', async (data, callback) => {
    try {
      const validated = messageSchema.parse(data);
      
      // Save to database
      await messageRepository.create({
        roomId: validated.room,
        authorId: socket.data.userId,
        content: validated.content,
      });
      
      // Broadcast to room
      io.to(validated.room).emit('message', {
        from: socket.data.username,
        content: validated.content,
        timestamp: new Date(),
      });
      
      callback({ success: true });
    } catch (error) {
      callback({ success: false });
    }
  });
  
  socket.on('disconnect', () => {
    console.log(`User disconnected: ${socket.data.username}`);
  });
});
```
```

**3. Add Message Queue Integration**
```markdown
## Message Queues & Background Jobs

### BullMQ with TypeScript
```typescript
import { Queue, Worker, Job } from 'bullmq';
import { z } from 'zod';

// Job payload schemas
const emailJobSchema = z.object({
  to: z.string().email(),
  subject: z.string(),
  body: z.string(),
  templateId: z.string().optional(),
});

type EmailJobPayload = z.infer<typeof emailJobSchema>;

// Queue setup
const emailQueue = new Queue<EmailJobPayload>('emails', {
  connection: {
    host: process.env.REDIS_HOST,
    port: Number(process.env.REDIS_PORT),
  },
  defaultJobOptions: {
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 1000,
    },
    removeOnComplete: {
      age: 3600, // Keep for 1 hour
      count: 100,
    },
    removeOnFail: {
      age: 86400, // Keep failed jobs for 24 hours
    },
  },
});

// Producer
export class EmailService {
  async sendEmail(data: EmailJobPayload): Promise<void> {
    const validated = emailJobSchema.parse(data);
    
    await emailQueue.add('send-email', validated, {
      priority: data.templateId?.includes('urgent') ? 1 : 10,
    });
  }
  
  async sendBulkEmails(recipients: string[], subject: string, body: string): Promise<void> {
    const jobs = recipients.map((to) => ({
      name: 'send-email',
      data: { to, subject, body },
    }));
    
    await emailQueue.addBulk(jobs);
  }
}

// Worker
const emailWorker = new Worker<EmailJobPayload>(
  'emails',
  async (job: Job<EmailJobPayload>) => {
    const { to, subject, body, templateId } = job.data;
    
    console.log(`Processing email job ${job.id} for ${to}`);
    
    try {
      // Send email using provider (SendGrid, AWS SES, etc.)
      await emailProvider.send({
        to,
        subject,
        body,
        templateId,
      });
      
      console.log(`Email sent successfully to ${to}`);
      
      // Update job progress
      await job.updateProgress(100);
      
      return { success: true, sentAt: new Date() };
    } catch (error) {
      console.error(`Failed to send email to ${to}:`, error);
      throw error; // Will trigger retry
    }
  },
  {
    connection: {
      host: process.env.REDIS_HOST,
      port: Number(process.env.REDIS_PORT),
    },
    concurrency: 10,
  }
);

// Event handlers
emailWorker.on('completed', (job) => {
  console.log(`Job ${job.id} completed`);
});

emailWorker.on('failed', (job, err) => {
  console.error(`Job ${job?.id} failed:`, err);
});
```
```

**4. Add OpenTelemetry Tracing**
```markdown
## Distributed Tracing with OpenTelemetry

### Express + OpenTelemetry Setup
```typescript
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { Resource } from '@opentelemetry/resources';
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions';

// Initialize before importing other modules
const sdk = new NodeSDK({
  resource: new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]: 'my-api',
    [SemanticResourceAttributes.SERVICE_VERSION]: '1.0.0',
  }),
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318/v1/traces',
  }),
  instrumentations: [
    getNodeAutoInstrumentations({
      '@opentelemetry/instrumentation-fs': { enabled: false },
    }),
  ],
});

sdk.start();

process.on('SIGTERM', () => {
  sdk.shutdown()
    .then(() => console.log('Tracing terminated'))
    .catch((error) => console.log('Error terminating tracing', error))
    .finally(() => process.exit(0));
});

// Custom spans in service layer
import { trace, SpanStatusCode } from '@opentelemetry/api';

export class OrderService {
  private tracer = trace.getTracer('order-service', '1.0.0');
  
  async processOrder(orderId: string): Promise<Order> {
    const span = this.tracer.startSpan('processOrder', {
      attributes: {
        'order.id': orderId,
      },
    });
    
    try {
      // Business logic with nested spans
      const order = await this.fetchOrder(orderId);
      await this.validateInventory(order);
      await this.processPayment(order);
      
      span.setStatus({ code: SpanStatusCode.OK });
      return order;
    } catch (error) {
      span.recordException(error as Error);
      span.setStatus({
        code: SpanStatusCode.ERROR,
        message: (error as Error).message,
      });
      throw error;
    } finally {
      span.end();
    }
  }
  
  private async fetchOrder(orderId: string): Promise<Order> {
    const span = this.tracer.startSpan('fetchOrder');
    try {
      const order = await orderRepository.findById(orderId);
      span.setAttribute('order.total', order.total);
      return order;
    } finally {
      span.end();
    }
  }
}
```
```

**5. Add Tool Permissions**
```markdown
Add to frontmatter:
```yaml
permission:
  bash:
    "*": ask
    "npm test*": allow
    "npm run build": allow
    "npm run lint": allow
    "pnpm test*": allow
    "pnpm build": allow
    "docker-compose up*": allow
    "docker build*": allow
```

---

### 4. DevOps Infrastructure Agent

**File Analyzed:** `devops-infrastructure.md`

#### Domain Coverage & Specialization (10/10)

**Exceptional Strengths:**
- **Comprehensive IaC coverage:** OpenTofu (preferred), Terraform, ARM templates, Bicep
- **Excellent GitOps integration:** ArgoCD, ApplicationSets, Image Updater
- **Strong container orchestration:** Kubernetes, Helm, Kustomize, Service Mesh considerations
- **Multi-language support:** Python, Bash, Java/Kotlin context
- **Robust CI/CD:** GitHub Actions with OIDC, Azure Pipelines alternative
- **Outstanding security focus:** DevSecOps, CSPM, least privilege, workload identity
- **Operational excellence:** Monitoring, logging, chaos engineering, SLO tracking
- **Database operations:** Migrations, backup, HA strategies

**Areas of Excellence:**
- ArgoCD integration is extremely well-documented
- Workload identity over static credentials emphasized (modern best practice)
- Compliance as Code integration (OPA, Checkov, Conftest)
- Container registry management and promotion strategies
- Cost management and allocation guidance

#### Tool Permissions & Capabilities (9/10)

**Strengths:**
- Good kubectl read-only permissions
- Docker read-only commands
- Terraform/OpenTofu validation and planning allowed

**Improvements Needed:**
- Consider allowing `kubectl logs` for debugging
- Add `kubectl exec` with ask permission for troubleshooting
- Consider `helm template` and `helm diff` for preview
- Add `tofu apply` with ask permission (currently only plan/validate)

#### Prompt Quality & Clarity (10/10)

**Exceptional Strengths:**
- Outstanding principles section (IaC, Automation, Security by Design, DevSecOps)
- Excellent organization by technology domain
- Strong emphasis on idempotency and automation
- Clear commit standards (Conventional Commits)
- Measurable value and developer experience emphasized

#### Examples & Use Cases (6/10)

**Major Gap:**
- **Almost no concrete code examples** despite comprehensive guidance
- Conceptual coverage is excellent, but lacks implementation details

**Missing Examples:**
- Terraform/OpenTofu module example
- ArgoCD Application manifest
- GitHub Actions workflow for GitOps
- Kubernetes deployment with proper resource limits, health checks, security context
- Helm chart structure
- Python automation script example
- Ansible/Saltstack state example

#### Specific Improvement Recommendations

**1. Add Infrastructure as Code Examples**
```markdown
## OpenTofu/Terraform Module Examples

### Reusable AKS Module
```hcl
# modules/aks-cluster/variables.tf
variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "node_pools" {
  description = "Node pool configurations"
  type = map(object({
    vm_size             = string
    node_count          = number
    max_pods            = number
    availability_zones  = list(string)
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
  }))
}

variable "network_config" {
  description = "Network configuration"
  type = object({
    vnet_id                 = string
    subnet_id               = string
    dns_service_ip          = string
    service_cidr            = string
    pod_cidr                = string
  })
}

# modules/aks-cluster/main.tf
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.cluster_name}-dns"
  
  # Workload Identity (modern best practice)
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  
  default_node_pool {
    name                = "system"
    vm_size             = "Standard_D4s_v5"
    node_count          = 3
    vnet_subnet_id      = var.network_config.subnet_id
    zones               = ["1", "2", "3"]
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 10
    
    upgrade_settings {
      max_surge = "33%"
    }
  }
  
  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    dns_service_ip     = var.network_config.dns_service_ip
    service_cidr       = var.network_config.service_cidr
    pod_cidr           = var.network_config.pod_cidr
    load_balancer_sku  = "standard"
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  azure_policy_enabled = true
  
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  }
  
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }
  
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}

# Additional node pools
resource "azurerm_kubernetes_cluster_node_pool" "workload" {
  for_each = var.node_pools
  
  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  max_pods              = each.value.max_pods
  zones                 = each.value.availability_zones
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  
  node_labels = {
    "workload-type" = each.key
  }
  
  upgrade_settings {
    max_surge = "33%"
  }
}

# modules/aks-cluster/outputs.tf
output "cluster_id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.main.oidc_issuer_url
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.main.kubelet_identity[0]
}
```

### Root Module Using AKS Module
```hcl
# environments/production/main.tf
terraform {
  required_version = ">= 1.14"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "production.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

module "aks_production" {
  source = "../../modules/aks-cluster"
  
  cluster_name = "prod-aks-001"
  location     = "eastus"
  
  network_config = {
    vnet_id        = data.azurerm_virtual_network.main.id
    subnet_id      = data.azurerm_subnet.aks.id
    dns_service_ip = "10.1.0.10"
    service_cidr   = "10.1.0.0/16"
    pod_cidr       = "10.2.0.0/16"
  }
  
  node_pools = {
    compute = {
      vm_size             = "Standard_D8s_v5"
      node_count          = 3
      max_pods            = 110
      availability_zones  = ["1", "2", "3"]
      enable_auto_scaling = true
      min_count           = 3
      max_count           = 20
    }
    memory = {
      vm_size             = "Standard_E8s_v5"
      node_count          = 2
      max_pods            = 110
      availability_zones  = ["1", "2", "3"]
      enable_auto_scaling = true
      min_count           = 2
      max_count           = 10
    }
  }
}
```
```

**2. Add Kubernetes Manifests Examples**
```markdown
## Production-Ready Kubernetes Manifests

### Complete Deployment with Best Practices
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: production
  labels:
    app: api-server
    version: v1.2.0
    tier: backend
spec:
  replicas: 3
  revisionHistoryLimit: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
        version: v1.2.0
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
        prometheus.io/path: "/metrics"
    spec:
      # Security contexts
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
        seccompProfile:
          type: RuntimeDefault
      
      # Workload identity (Azure)
      serviceAccountName: api-server
      
      # Topology spread for HA
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: topology.kubernetes.io/zone
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: api-server
      
      # Anti-affinity for pod distribution
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - api-server
                topologyKey: kubernetes.io/hostname
      
      containers:
        - name: api-server
          image: myregistry.azurecr.io/api-server:v1.2.0
          imagePullPolicy: IfNotPresent
          
          # Security context
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL
          
          ports:
            - name: http
              containerPort: 8080
              protocol: TCP
          
          # Resource requests and limits
          resources:
            requests:
              cpu: 500m
              memory: 512Mi
            limits:
              cpu: 1000m
              memory: 1Gi
          
          # Health checks
          livenessProbe:
            httpGet:
              path: /health/live
              port: http
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          
          readinessProbe:
            httpGet:
              path: /health/ready
              port: http
            initialDelaySeconds: 10
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          
          startupProbe:
            httpGet:
              path: /health/startup
              port: http
            initialDelaySeconds: 0
            periodSeconds: 10
            timeoutSeconds: 3
            failureThreshold: 30
          
          # Environment variables
          env:
            - name: NODE_ENV
              value: "production"
            - name: LOG_LEVEL
              value: "info"
            - name: PORT
              value: "8080"
            
            # From ConfigMap
            - name: FEATURE_FLAGS
              valueFrom:
                configMapKeyRef:
                  name: api-config
                  key: feature_flags
            
            # From Secret
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: api-secrets
                  key: database_url
            
            # Downward API
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          
          # Volume mounts
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: cache
              mountPath: /app/cache
      
      # Volumes
      volumes:
        - name: tmp
          emptyDir: {}
        - name: cache
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: api-server
  namespace: production
  labels:
    app: api-server
spec:
  type: ClusterIP
  sessionAffinity: ClientIP
  selector:
    app: api-server
  ports:
    - name: http
      port: 80
      targetPort: http
      protocol: TCP
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-server
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-server
  minReplicas: 3
  maxReplicas: 20
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 50
          periodSeconds: 60
        - type: Pods
          value: 2
          periodSeconds: 60
      selectPolicy: Max
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: api-server
  namespace: production
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: api-server
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-server
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: api-server
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
        - podSelector:
            matchLabels:
              app: internal-client
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: postgres
      ports:
        - protocol: TCP
          port: 5432
    - to:
        - podSelector:
            matchLabels:
              app: redis
      ports:
        - protocol: TCP
          port: 6379
    # DNS
    - to:
        - namespaceSelector:
            matchLabels:
              name: kube-system
        - podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
    # External HTTPS
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: TCP
          port: 443
```
```

**3. Add ArgoCD GitOps Examples**
```markdown
## ArgoCD Application Manifests

### Application Definition
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: api-server-production
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: production
  
  source:
    repoURL: https://github.com/myorg/api-server
    targetRevision: main
    path: k8s/overlays/production
    
    # Kustomize configuration
    kustomize:
      images:
        - myregistry.azurecr.io/api-server:v1.2.0
  
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    
    syncOptions:
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
    
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
  
  revisionHistoryLimit: 10
  
  # Health assessment
  ignoreDifferences:
    - group: apps
      kind: Deployment
      jsonPointers:
        - /spec/replicas  # Ignore replicas managed by HPA
---
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: api-server-multi-env
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - env: development
            cluster: dev-cluster
            replicas: "2"
          - env: staging
            cluster: staging-cluster
            replicas: "3"
          - env: production
            cluster: prod-cluster
            replicas: "5"
  
  template:
    metadata:
      name: 'api-server-{{env}}'
    spec:
      project: default
      
      source:
        repoURL: https://github.com/myorg/api-server
        targetRevision: main
        path: k8s/overlays/{{env}}
      
      destination:
        server: '{{cluster}}'
        namespace: '{{env}}'
      
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
```

### Progressive Delivery with Argo Rollouts
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: api-server
  namespace: production
spec:
  replicas: 5
  
  strategy:
    canary:
      steps:
        - setWeight: 20
        - pause: { duration: 5m }
        - setWeight: 40
        - pause: { duration: 5m }
        - setWeight: 60
        - pause: { duration: 5m }
        - setWeight: 80
        - pause: { duration: 5m }
      
      # Analysis for automated promotion/rollback
      analysis:
        templates:
          - templateName: success-rate
        startingStep: 2
        args:
          - name: service-name
            value: api-server
      
      trafficRouting:
        nginx:
          stableIngress: api-server
          annotationPrefix: nginx.ingress.kubernetes.io
  
  selector:
    matchLabels:
      app: api-server
  
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api-server
          image: myregistry.azurecr.io/api-server:v1.2.0
          ports:
            - containerPort: 8080
---
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: success-rate
  namespace: production
spec:
  args:
    - name: service-name
  
  metrics:
    - name: success-rate
      interval: 1m
      successCondition: result[0] >= 0.95
      failureLimit: 3
      provider:
        prometheus:
          address: http://prometheus:9090
          query: |
            sum(rate(
              http_requests_total{service="{{args.service-name}}",status!~"5.."}[5m]
            )) /
            sum(rate(
              http_requests_total{service="{{args.service-name}}"}[5m]
            ))
```
```

**4. Add GitHub Actions CI/CD Example**
```markdown
## GitHub Actions CI/CD Pipeline

### Complete GitOps Workflow
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  REGISTRY: myregistry.azurecr.io
  IMAGE_NAME: api-server

permissions:
  id-token: write  # Required for OIDC
  contents: read
  packages: write

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run linter
        run: npm run lint
      
      - name: Run unit tests
        run: npm test -- --coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v4
        with:
          files: ./coverage/lcov.info

  security:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'
      
      - name: Upload Trivy results
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: 'trivy-results.sarif'

  build-and-push:
    runs-on: ubuntu-latest
    needs: [test, security]
    if: github.event_name == 'push'
    outputs:
      image-tag: ${{ steps.meta.outputs.version }}
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      
      - name: Azure Login (OIDC)
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      
      - name: Login to ACR
        run: az acr login --name myregistry
      
      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix={{branch}}-
            type=semver,pattern={{version}}
      
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
          provenance: true
          sbom: true
      
      - name: Scan image
        run: |
          az acr task run \
            --registry myregistry \
            --cmd '$Registry/$Repository:$Tag' \
            /dev/null

  update-manifests:
    runs-on: ubuntu-latest
    needs: build-and-push
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
        with:
          repository: myorg/k8s-manifests
          token: ${{ secrets.GITOPS_TOKEN }}
      
      - name: Update image tag
        run: |
          cd overlays/production
          kustomize edit set image \
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ needs.build-and-push.outputs.image-tag }}
      
      - name: Commit and push
        run: |
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add .
          git commit -m "Update ${{ env.IMAGE_NAME }} to ${{ needs.build-and-push.outputs.image-tag }}"
          git push
```
```

**5. Add Python Automation Example**
```markdown
## Python Automation Scripts

### Azure Resource Cleanup Script
```python
#!/usr/bin/env python3
"""
Azure resource cleanup automation script.
Removes orphaned resources to reduce costs.
"""

import logging
from datetime import datetime, timedelta
from typing import List, Dict
from dataclasses import dataclass

from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.storage import StorageManagementClient

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@dataclass
class ResourceCleanupConfig:
    """Configuration for resource cleanup."""
    subscription_id: str
    resource_group: str
    max_age_days: int = 30
    dry_run: bool = True
    excluded_tags: List[str] = None

class AzureResourceCleaner:
    """Automated cleanup of unused Azure resources."""
    
    def __init__(self, config: ResourceCleanupConfig):
        self.config = config
        self.credential = DefaultAzureCredential()
        
        self.compute_client = ComputeManagementClient(
            self.credential,
            config.subscription_id
        )
        self.network_client = NetworkManagementClient(
            self.credential,
            config.subscription_id
        )
        self.storage_client = StorageManagementClient(
            self.credential,
            config.subscription_id
        )
    
    def find_orphaned_disks(self) -> List[Dict]:
        """Find unattached managed disks older than threshold."""
        logger.info("Scanning for orphaned disks...")
        
        orphaned = []
        cutoff_date = datetime.now() - timedelta(days=self.config.max_age_days)
        
        for disk in self.compute_client.disks.list_by_resource_group(
            self.config.resource_group
        ):
            # Skip if attached to VM
            if disk.managed_by:
                continue
            
            # Skip if protected by tag
            if self._is_protected(disk.tags):
                continue
            
            # Check age
            if disk.time_created < cutoff_date:
                orphaned.append({
                    'name': disk.name,
                    'size_gb': disk.disk_size_gb,
                    'created': disk.time_created,
                    'cost_estimate': self._estimate_disk_cost(disk)
                })
        
        logger.info(f"Found {len(orphaned)} orphaned disks")
        return orphaned
    
    def find_unused_nics(self) -> List[Dict]:
        """Find network interfaces not attached to VMs."""
        logger.info("Scanning for unused NICs...")
        
        unused = []
        
        for nic in self.network_client.network_interfaces.list(
            self.config.resource_group
        ):
            if not nic.virtual_machine and not self._is_protected(nic.tags):
                unused.append({
                    'name': nic.name,
                    'location': nic.location,
                    'private_ip': nic.ip_configurations[0].private_ip_address if nic.ip_configurations else None
                })
        
        logger.info(f"Found {len(unused)} unused NICs")
        return unused
    
    def find_old_snapshots(self) -> List[Dict]:
        """Find snapshots older than retention period."""
        logger.info("Scanning for old snapshots...")
        
        old_snapshots = []
        cutoff_date = datetime.now() - timedelta(days=self.config.max_age_days)
        
        for snapshot in self.compute_client.snapshots.list_by_resource_group(
            self.config.resource_group
        ):
            if snapshot.time_created < cutoff_date and not self._is_protected(snapshot.tags):
                old_snapshots.append({
                    'name': snapshot.name,
                    'size_gb': snapshot.disk_size_gb,
                    'created': snapshot.time_created
                })
        
        logger.info(f"Found {len(old_snapshots)} old snapshots")
        return old_snapshots
    
    def cleanup(self) -> Dict[str, int]:
        """Execute cleanup of identified resources."""
        results = {
            'disks_deleted': 0,
            'nics_deleted': 0,
            'snapshots_deleted': 0,
            'errors': 0
        }
        
        # Find resources
        orphaned_disks = self.find_orphaned_disks()
        unused_nics = self.find_unused_nics()
        old_snapshots = self.find_old_snapshots()
        
        if self.config.dry_run:
            logger.info("DRY RUN - No resources will be deleted")
            logger.info(f"Would delete: {len(orphaned_disks)} disks, {len(unused_nics)} NICs, {len(old_snapshots)} snapshots")
            return results
        
        # Delete disks
        for disk in orphaned_disks:
            try:
                logger.info(f"Deleting disk: {disk['name']}")
                self.compute_client.disks.begin_delete(
                    self.config.resource_group,
                    disk['name']
                )
                results['disks_deleted'] += 1
            except Exception as e:
                logger.error(f"Failed to delete disk {disk['name']}: {e}")
                results['errors'] += 1
        
        # Delete NICs
        for nic in unused_nics:
            try:
                logger.info(f"Deleting NIC: {nic['name']}")
                self.network_client.network_interfaces.begin_delete(
                    self.config.resource_group,
                    nic['name']
                )
                results['nics_deleted'] += 1
            except Exception as e:
                logger.error(f"Failed to delete NIC {nic['name']}: {e}")
                results['errors'] += 1
        
        # Delete snapshots
        for snapshot in old_snapshots:
            try:
                logger.info(f"Deleting snapshot: {snapshot['name']}")
                self.compute_client.snapshots.begin_delete(
                    self.config.resource_group,
                    snapshot['name']
                )
                results['snapshots_deleted'] += 1
            except Exception as e:
                logger.error(f"Failed to delete snapshot {snapshot['name']}: {e}")
                results['errors'] += 1
        
        return results
    
    def _is_protected(self, tags: Dict[str, str]) -> bool:
        """Check if resource is protected from cleanup."""
        if not tags or not self.config.excluded_tags:
            return False
        
        return any(tag in tags for tag in self.config.excluded_tags)
    
    def _estimate_disk_cost(self, disk) -> float:
        """Estimate monthly cost of disk."""
        # Simplified cost estimation (actual costs vary by region/type)
        cost_per_gb = {
            'Standard_LRS': 0.05,
            'StandardSSD_LRS': 0.075,
            'Premium_LRS': 0.12
        }
        
        rate = cost_per_gb.get(disk.sku.name, 0.05)
        return disk.disk_size_gb * rate

def main():
    """Main execution."""
    config = ResourceCleanupConfig(
        subscription_id="your-subscription-id",
        resource_group="your-resource-group",
        max_age_days=30,
        dry_run=True,  # Set to False to actually delete
        excluded_tags=["environment:production", "protected:true"]
    )
    
    cleaner = AzureResourceCleaner(config)
    results = cleaner.cleanup()
    
    logger.info("Cleanup completed:")
    logger.info(f"  Disks deleted: {results['disks_deleted']}")
    logger.info(f"  NICs deleted: {results['nics_deleted']}")
    logger.info(f"  Snapshots deleted: {results['snapshots_deleted']}")
    logger.info(f"  Errors: {results['errors']}")

if __name__ == "__main__":
    main()
```
```

---

## Cross-Cutting Recommendations

### 1. Standardize Agent Structure

All agents should include these sections in this order:
```markdown
1. Frontmatter (metadata, permissions, model)
2. Brief Description (1-2 sentences)
3. When to Use This Agent (with examples like TypeScript agent)
4. Core Expertise Areas (bullet list)
5. Version Requirements / Tooling
6. Key Principles & Philosophy
7. Domain-Specific Sections (organized by topic)
8. Code Examples (comprehensive, production-ready)
9. Testing Strategies
10. Best Practices Checklist
11. Common Issues & Troubleshooting
12. References / Further Reading
```

### 2. Add Missing Cross-Cutting Concerns

All backend agents should cover:
- **Observability:** Distributed tracing, metrics collection, structured logging
- **API Gateway patterns:** Rate limiting, authentication, request transformation
- **Service mesh integration:** For complex deployments
- **Message queues:** Async communication patterns
- **Circuit breakers & retries:** Resilience patterns
- **Feature flags:** Progressive rollout capabilities
- **Health checks:** Liveness, readiness, startup probes
- **Graceful shutdown:** Signal handling and connection draining

### 3. Enhance Examples with Real-World Scenarios

Add scenario-based examples:
- "Building a multi-tenant SaaS backend"
- "Implementing CQRS with event sourcing"
- "Creating a GraphQL API with subscriptions"
- "Setting up blue-green deployments"
- "Implementing rate limiting per user tier"

### 4. Add Decision Trees

Help users make technology choices:
```markdown
## When to Use Which Database?

**PostgreSQL (Relational)**
- Use when: ACID compliance required, complex queries, strong consistency
- Examples: User accounts, financial transactions, inventory

**MongoDB (Document)**
- Use when: Flexible schema, hierarchical data, rapid iteration
- Examples: Content management, catalogs, user profiles

**Redis (Key-Value)**
- Use when: Caching, session storage, real-time analytics
- Examples: Cache layer, rate limiting, pub/sub

**Elasticsearch (Search)**
- Use when: Full-text search, log aggregation, analytics
- Examples: Product search, log analysis, autocomplete
```

### 5. Add Performance Optimization Sections

Each agent should include:
- Database query optimization techniques
- Caching strategies (Redis, in-memory, CDN)
- Connection pooling best practices
- Load testing guidance
- Profiling tools and techniques

### 6. Add Security Checklists

Comprehensive security coverage:
- [ ] All secrets in vault/secrets manager
- [ ] Input validation on all endpoints
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output encoding)
- [ ] CSRF protection enabled
- [ ] Rate limiting implemented
- [ ] Authentication required on protected endpoints
- [ ] Authorization checks on all resources
- [ ] TLS/HTTPS enforced
- [ ] Security headers configured (CSP, HSTS, etc.)
- [ ] Dependency vulnerability scanning in CI/CD
- [ ] Least privilege IAM roles

### 7. Standardize Bash Permissions

Recommended permissions template:
```yaml
permission:
  bash:
    "*": ask
    # Language-specific build/test
    "mvn clean*": allow
    "mvn test*": allow
    "./gradlew test*": allow
    "go test*": allow
    "npm test*": allow
    # Linting and formatting
    "npm run lint": allow
    "go fmt": allow
    "go vet": allow
    # Version checking
    "java -version": allow
    "node -v": allow
    "go version": allow
    # Docker (local dev)
    "docker ps": allow
    "docker images": allow
    "docker-compose up*": ask
    # Kubernetes (read-only)
    "kubectl get*": allow
    "kubectl describe*": allow
    "kubectl logs*": allow
```

---

## Summary of Agent Quality Scores

| Agent | Domain Coverage | Tool Permissions | Prompt Quality | Examples | Overall |
|-------|----------------|------------------|----------------|----------|---------|
| **Java/Kotlin Backend** | 9/10 | 8/10 | 9/10 | 9/10 | **8.75/10** |
| **Go Backend API** | 9/10 | 9/10 | 10/10 | 7/10 | **8.75/10** |
| **TypeScript Backend** | 10/10 | 7/10 | 10/10 | 10/10 | **9.25/10** |
| **DevOps Infrastructure** | 10/10 | 9/10 | 10/10 | 6/10 | **8.75/10** |

---

## Priority Action Items

### High Priority (Implement First)
1. **Java/Kotlin:** Add microservices patterns (Spring Cloud), Kotlin coroutines examples, observability setup
2. **Go:** Add comprehensive code examples for all patterns described
3. **TypeScript:** Add bash permissions, GraphQL implementation, message queue patterns
4. **DevOps:** Add concrete IaC, Kubernetes, ArgoCD, and GitHub Actions examples

### Medium Priority
5. Add "When to Use This Agent" sections to Java/Kotlin and Go agents
6. Add troubleshooting guides to all agents
7. Standardize security checklists across all agents
8. Add performance optimization sections

### Low Priority
9. Add decision trees for technology selection
10. Add scenario-based examples
11. Add references/further reading sections

---

## Conclusion

The backend agent suite is **strong overall** with excellent technical depth and modern best practices. The TypeScript Backend agent serves as the **gold standard** for documentation quality and example comprehensiveness. Key improvements focus on:

1. **Adding missing patterns:** Microservices, event-driven architecture, service mesh
2. **Enhancing examples:** Especially for Go and DevOps agents
3. **Standardizing structure:** Consistent sections across all agents
4. **Cross-cutting concerns:** Observability, security, performance optimization

Implementing these recommendations will create a **world-class** backend development agent suite that provides comprehensive guidance for modern cloud-native application development.
