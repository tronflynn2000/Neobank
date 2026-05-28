# Neobanco

> A modern, scalable digital banking platform built with industry-standard engineering practices and clean architecture principles.

[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/) 
[![Express.js](https://img.shields.io/badge/Express.js-5.2.1-blue)](https://expressjs.com/) 
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18+-blue)](https://www.postgresql.org/) 
[![Status](https://img.shields.io/badge/Status-Active%20Development-yellow)](#project-roadmap)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
- [Architecture Diagram](#architecture-diagram)
- [Database Schema](#database-schema)
- [Authentication & Security](#authentication--security)
- [Development Practices](#development-practices)
- [Project Roadmap](#project-roadmap)
- [Contributing](#contributing)

---

## Overview

**Neobanco** is a digital banking application designed to provide a robust, secure, and scalable banking platform for managing accounts, transactions, and user authentication. Built with a focus on clean code principles, design patterns, and modern software engineering practices, Neobanco demonstrates professional-grade backend architecture suitable for production environments.

### Key Highlights

- **Secure Authentication**: Session-based authentication with Passport.js and PBKDF2-SHA256 password hashing (310,000 iterations)
- **Robust Database**: PostgreSQL relational database with proper indexing and constraints
- **Clean Architecture**: Well-organized codebase following SOLID principles and Design Patterns
- **Sample Data**: Pre-populated database with 30 test clients and 30 sample accounts
- **Developer-Friendly**: Clear API endpoints and comprehensive documentation

**Current Status**: Backend-focused with a fully functional REST API. Frontend development is planned for subsequent phases.

---

## Features

### ✅ Implemented Features

- **User Authentication**
  - User registration with email uniqueness validation
  - Secure login with session management
  - Password hashing using PBKDF2-SHA256 with 310,000 iterations
  - Session-based authentication via Passport.js

- **Account Management**
  - Account creation and association with users
  - Account balance tracking (12.2 numeric precision)
  - Account retrieval via protected endpoints

- **API Foundation**
  - RESTful API endpoints with proper HTTP status codes
  - Protected routes requiring authentication
  - Input validation and error handling

### 🚀 Planned Features

- **Transaction System**
  - Transfer funds between accounts
  - Transaction history and ledger
  - Real-time balance updates

- **Frontend Application**
  - React-based web interface
  - User dashboard
  - Account and transaction management UI

- **Advanced Features**
  - Multi-user account support
  - Transaction filters and search
  - Account analytics and reporting
  - Card management (virtual/physical)
  - API rate limiting

- **Testing & Quality**
  - Comprehensive unit test suite
  - Integration tests
  - API endpoint testing
  - CI/CD pipeline

---

## Tech Stack

### Backend

| Technology | Version | Purpose |
|-----------|---------|---------|
| **Node.js** | 18+ | JavaScript runtime |
| **Express.js** | 5.2.1 | Web framework |
| **Passport.js** | 0.7.0 | Authentication middleware |
| **body-parser** | 2.2.2 | Request body parsing |
| **EJS** | 5.0.1 | Template engine |
| **dotenv** | 17.4.2 | Environment configuration |

### Database

| Technology | Version | Purpose |
|-----------|---------|---------|
| **PostgreSQL** | 18.0 | Relational database |
| **pg** | 8.20.0 | PostgreSQL client for Node.js |

### Development Tools

- **ES Modules**: Modern JavaScript module system
- **npm**: Package management
- **.env Configuration**: Secure credential management

---

## Project Structure

```
Neobanco/
├── backend/                              # Backend application
│   ├── database/                         # Database scripts
│   │   ├── init.sql                      # Sample data and initialization (30 clients, 30 accounts)
│   │   └── schema_bank.sql               # Complete database schema with constraints
│   ├── index.js                          # Main Express server and API endpoints
│   ├── package.json                      # Backend dependencies
│   └── .gitignore                        # Git ignore rules (includes .env)
├── frontend/                             # Frontend application (currently empty)
├── node_modules/                         # Installed dependencies
├── package.json                          # Root package configuration
└── README.md                             # Project documentation
```

### Key Files

- **`backend/index.js`**: Main Express server with all API endpoints, session configuration, and authentication logic
- **`backend/database/schema_bank.sql`**: Database schema definition with three core tables and relationships
- **`backend/database/init.sql`**: Sample database initialization with test data
- **`backend/package.json`**: Lists all backend dependencies and scripts

---

## Getting Started

### Prerequisites

- **Node.js**: v18 or higher ([Download](https://nodejs.org/))
- **PostgreSQL**: v14 or higher ([Download](https://www.postgresql.org/download/))
- **npm**: v9 or higher (included with Node.js)

### Installation

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd Neobanco
```

#### 2. Install Dependencies

```bash
npm install
cd backend
npm install
```

#### 3. Set Up Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
# Server Configuration
PORT=3000

# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/neobanco

# Session Configuration
SESSION_SECRET=your-secure-session-secret-key-here
```

**Important**: Replace `username`, `password`, and `your-secure-session-secret-key-here` with actual values. For production, use strong, randomly generated values for `SESSION_SECRET`.

#### 4. Create and Initialize the Database

```bash
# Create database
createdb neobanco

# Apply schema
psql -U username -d neobanco -f backend/database/schema_bank.sql

# Load sample data
psql -U username -d neobanco -f backend/database/init.sql
```

#### 5. Run the Server

```bash
cd backend
npm start
```

The server should now be running at `http://localhost:3000`.

### Verify Installation

```bash
# Test the server
curl http://localhost:3000/

# Expected response:
# { "message": "Hello World" }
```

---

## API Documentation

### Base URL

```
http://localhost:3000
```

### Authentication Endpoints

#### Register a New User

```http
POST /register
Content-Type: application/json

{
  "name": "John",
  "surname": "Doe",
  "email": "john.doe@example.com",
  "password": "SecurePassword123!",
  "phone_number": "+1-555-0123"
}
```

**Success Response** (201 Created):
```json
{
  "message": "User registered successfully",
  "user_id": 1001
}
```

**Error Responses**:
- `400 Bad Request`: Missing required fields
- `409 Conflict`: Email already registered

---

#### Login

```http
POST /login
Content-Type: application/json

{
  "email": "john.doe@example.com",
  "password": "SecurePassword123!"
}
```

**Success Response** (200 OK):
```json
{
  "message": "Login successful",
  "user": {
    "id": 1001,
    "name": "John",
    "surname": "Doe",
    "email": "john.doe@example.com"
  }
}
```

**Error Responses**:
- `400 Bad Request`: Missing email or password
- `401 Unauthorized`: Invalid credentials

---

### Protected Endpoints

#### Get Protected Content

```http
GET /secrets
```

**Headers Required**:
- Session cookie (automatically set after login)

**Success Response** (200 OK):
```json
{
  "message": "This is a secret content only for authenticated users"
}
```

**Error Responses**:
- `401 Unauthorized`: Not authenticated

---

### Utility Endpoints

#### Home Page

```http
GET /
```

**Response** (200 OK):
```json
{
  "message": "Hello World"
}
```

#### About Page

```http
GET /about
```

**Response** (200 OK):
```json
{
  "message": "Welcome to Neobanco - Digital Banking Platform"
}
```

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     Client Application                       │
│                  (Browser / API Client)                      │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP/HTTPS
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              Express.js Web Server (Port 3000)               │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Middleware Stack                                     │   │
│  │ • body-parser (request parsing)                      │   │
│  │ • express-session (session management)               │   │
│  │ • Passport.js (authentication)                       │   │
│  └──────────────────────────────────────────────────────┘   │
│                         │                                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ API Routes                                           │   │
│  │ • POST /register      - User registration            │   │
│  │ • POST /login         - User authentication          │   │
│  │ • GET /secrets        - Protected route              │   │
│  │ • GET /               - Health check                 │   │
│  │ • GET /about          - Info endpoint                │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │ SQL Queries
                         ▼
┌─────────────────────────────────────────────────────────────┐
│           PostgreSQL Relational Database (Port 5432)        │
│                                                               │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐   │
│  │   client       │  │   account      │  │ transaction  │   │
│  │ ├─ id          │  │ ├─ id          │  │ ├─ id        │   │
│  │ ├─ name        │  │ ├─ amount      │  │ ├─ origin    │   │
│  │ ├─ email       │  │ ├─ client_id   │  │ ├─ dest      │   │
│  │ ├─ password    │  │ └─ (FK)        │  │ └─ account   │   │
│  │ └─ ...         │  │                │  │    _id (FK)  │   │
│  └────────────────┘  └────────────────┘  └──────────────┘   │
│         │                    │                                 │
│         └────────┬───────────┘                                 │
│                  │ Relationships                              │
└──────────────────┼──────────────────────────────────────────┘
                   │ Primary Keys, Foreign Keys, Indexes
                   ▼
         [Data Persistence & Integrity]
```

### Data Flow

1. **Client Request**: User submits credentials or requests protected resource
2. **Express Middleware**: Request processed through body-parser, session, and Passport middleware
3. **Authentication**: Passport.js validates credentials against PostgreSQL database
4. **Session Management**: Session created and stored in memory (default configuration)
5. **Database Operation**: Query executed on PostgreSQL
6. **Response**: Results returned to client

---

## Database Schema

### Tables Overview

#### `client` Table

Stores user account information.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing user ID (starts at 1001) |
| `name` | VARCHAR(50) | NOT NULL | User's first name |
| `surname` | VARCHAR(50) | NOT NULL | User's last name |
| `email` | VARCHAR(100) | NOT NULL, UNIQUE | User's email address |
| `password_hash` | TEXT | NOT NULL | PBKDF2-SHA256 hashed password |
| `phone_number` | VARCHAR(20) | | Optional phone number |
| `date_creation` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Account creation timestamp |

**Indexes**: 
- Primary key on `id`
- Unique index on `email`

---

#### `account` Table

Stores banking accounts associated with clients.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing account ID |
| `amount` | NUMERIC(12,2) | DEFAULT 0.00 | Account balance with 2 decimal precision |
| `client_id` | INTEGER | NOT NULL, FOREIGN KEY | Reference to client |
| `date_creation` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Account creation timestamp |

**Relationships**: 
- Foreign Key: `client_id` → `client.id`

**Indexes**:
- Primary key on `id`
- Index on `client_id` for efficient lookups

---

#### `transaction` Table

Prepared for transaction history and transfer records (not yet populated).

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing transaction ID |
| `origin` | VARCHAR | | Source account identifier |
| `destination` | VARCHAR | | Destination account identifier |
| `account_id` | INTEGER | FOREIGN KEY | Reference to account |
| `date_creation` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Transaction timestamp |

---

### Sample Data

The database is pre-populated with:
- **30 test clients** with varying account balances
- **30 sample accounts** with balances ranging from $0.00 to $100,000.00
- Ready for testing authentication, account retrieval, and transaction features

---

## Authentication & Security

### Authentication Flow

```
1. User Registration
   └─ Validates input (required fields, email format)
   └─ Checks email uniqueness in database
   └─ Hashes password using PBKDF2-SHA256
   └─ Stores user in 'client' table
   └─ Returns success/error response

2. User Login
   └─ Validates input (email and password required)
   └─ Retrieves user from database by email
   └─ Compares submitted password with stored hash
   └─ Creates session on successful authentication
   └─ Session ID stored in secure cookie
   └─ Client automatically authenticated for subsequent requests

3. Protected Route Access
   └─ Passport.js middleware checks session
   └─ If authenticated, request continues
   └─ If not authenticated, returns 401 Unauthorized
```

### Security Measures

| Measure | Implementation | Details |
|---------|-----------------|---------|
| **Password Hashing** | PBKDF2-SHA256 | 310,000 iterations (OWASP recommended) |
| **Session Management** | express-session | Secure cookie-based sessions |
| **Authentication** | Passport.js | Industry-standard authentication middleware |
| **Database** | PostgreSQL | ACID compliance, relational integrity |
| **Input Validation** | Server-side | Email format, required field checks |
| **Email Uniqueness** | Database constraint | UNIQUE constraint on client.email |

### Security Considerations & Future Improvements

#### ⚠️ Current Implementation Notes

- Session secret in `.env` should be a strong, randomly generated string
- Session storage currently in-memory (suitable for development)
- HTTPS/TLS recommended for production deployment
- CORS configuration should be implemented for frontend integration

#### 🔒 Recommended Production Enhancements

- [ ] Move session storage to Redis for distributed environments
- [ ] Implement HTTPS/TLS encryption
- [ ] Add rate limiting on authentication endpoints
- [ ] Implement refresh tokens for API authentication
- [ ] Add password complexity requirements during registration
- [ ] Implement account lockout after failed login attempts
- [ ] Add audit logging for security events
- [ ] Implement CORS with specific allowed origins
- [ ] Add helmet.js for HTTP security headers
- [ ] Implement API rate limiting (express-rate-limit)

---

## Development Practices

### Code Quality Standards

Neobanco is built following industry-standard software engineering principles:

#### Clean Code Principles

- **Meaningful Names**: Variables and functions have clear, descriptive names
- **Small Functions**: Functions are focused and single-purpose
- **DRY (Don't Repeat Yourself)**: Code reusability and minimal duplication
- **SOLID Principles**: Foundation for maintainable, scalable code

#### Design Patterns

- **MVC Pattern**: Separation of concerns (Models, Views, Controllers)
- **Middleware Pattern**: Express middleware for cross-cutting concerns
- **Strategy Pattern**: Passport.js authentication strategies
- **Repository Pattern**: Database abstraction layer

#### Code Organization

- Modular structure with clear separation of concerns
- Consistent naming conventions throughout the codebase
- Comprehensive error handling and validation
- RESTful API design principles

### Testing Strategy

- **Unit Tests**: Planned for individual functions and utilities
- **Integration Tests**: Planned for API endpoint testing
- **Database Tests**: Planned for data integrity verification
- **End-to-End Tests**: Planned for complete user workflows

### Version Control & Workflow

- **Git**: All changes tracked with meaningful commit messages
- **Branch Strategy**: Feature branches for development, main for stable releases
- **Code Review**: Peer review before merging to main branch

---

## Project Roadmap

### ✅ Phase 1: Foundation (Completed)

- [x] Project setup and structure
- [x] PostgreSQL database design and implementation
- [x] User authentication and registration system
- [x] Session management with Passport.js
- [x] Basic API endpoints
- [x] Sample data and testing database

### 🟡 Phase 2: Transaction System (In Progress)

- [ ] Account transfer functionality
- [ ] Transaction history and ledger
- [ ] Balance validation and updates
- [ ] Transaction rollback on failures
- [ ] Transaction API endpoints
- [ ] Comprehensive API documentation

### 🔵 Phase 3: Frontend Development (Planned)

- [ ] React application setup
- [ ] User dashboard
- [ ] Login/Registration UI
- [ ] Account management interface
- [ ] Transaction management UI
- [ ] Responsive design and accessibility

### 🔵 Phase 4: Testing & Quality (Planned)

- [ ] Unit test suite (Jest)
- [ ] Integration tests
- [ ] API endpoint testing
- [ ] Database migration tests
- [ ] End-to-end testing
- [ ] Code coverage targets (>80%)

### 🔵 Phase 5: Advanced Features (Planned)

- [ ] Multi-user account support
- [ ] Transaction filters and search
- [ ] Account analytics and reporting
- [ ] Card management (virtual/physical)
- [ ] Payment scheduling
- [ ] Notification system

### 🔵 Phase 6: Deployment & DevOps (Planned)

- [ ] Docker containerization
- [ ] CI/CD pipeline setup
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Monitoring and logging
- [ ] Production deployment

---

## Contributing

We welcome contributions from developers at all skill levels. To contribute to Neobanco:

### Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a feature branch**: `git checkout -b feature/your-feature-name`
4. **Make your changes** following our code standards
5. **Commit your work**: `git commit -m "Clear, descriptive commit message"`
6. **Push to your fork**: `git push origin feature/your-feature-name`
7. **Create a Pull Request** with a clear description of your changes

### Code Style Guidelines

- **JavaScript**: Use modern ES6+ features with Node.js conventions
- **Naming**: camelCase for variables/functions, PascalCase for classes
- **Formatting**: Consistent indentation (2 spaces), semicolons required
- **Comments**: Only for non-obvious logic; clean code explains itself
- **Validation**: Always validate user input at API boundaries

### Branch Naming Conventions

```
feature/short-description          # New features
bugfix/short-description           # Bug fixes
refactor/short-description         # Code refactoring
docs/short-description             # Documentation updates
test/short-description             # Test additions
```

### Commit Message Format

```
[Type] Brief description (50 chars or less)

Detailed explanation of changes (if needed)
- Point 1
- Point 2
```

**Types**: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

### Pull Request Process

- Include a clear title and description
- Reference any related issues
- Ensure all tests pass
- Follow the code style guidelines
- Respond to review feedback promptly

---

## Support & Contact

For questions, bug reports, or feature requests:

- **Issues**: Create an issue on GitHub
- **Discussions**: Participate in project discussions
- **Documentation**: Refer to the API documentation above

---

## Acknowledgments

Neobanco is built with modern technologies and best practices in software engineering:

- Express.js for robust web server framework
- PostgreSQL for reliable data persistence
- Passport.js for authentication abstraction
- Node.js community for excellent tools and libraries

---

**Last Updated**: May 28, 2026 | **Version**: 1.0.0 | **Status**: Active Development
