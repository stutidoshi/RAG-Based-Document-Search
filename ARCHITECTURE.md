# Architecture Documentation

## System Overview

This RAG-based document search backend follows a layered architecture:

```
┌─────────────────────────────────────────────────┐
│           Client (Frontend - TBD)               │
└──────────────────┬──────────────────────────────┘
                   │ HTTP/REST
                   ▼
┌─────────────────────────────────────────────────┐
│         Express.js API Server (Port 5000)       │
│  ┌───────────────────────────────────────────┐  │
│  │         Routes Layer                      │  │
│  │  auth, documents, search, feedback, etc.  │  │
│  └───────────────┬─────────────────────────┘  │
│                  │                              │
│  ┌───────────────▼─────────────────────────┐  │
│  │      Middleware Layer                   │  │
│  │  - JWT Authentication                   │  │
│  │  - File Upload (Multer)                 │  │
│  │  - Error Handling                       │  │
│  │  - Logging                              │  │
│  └───────────────┬─────────────────────────┘  │
│                  │                              │
│  ┌───────────────▼─────────────────────────┐  │
│  │    Controllers Layer                    │  │
│  │  - Business Logic                       │  │
│  │  - Data Processing                      │  │
│  │  - TF-IDF Calculation                   │  │
│  │  - Search Implementation                │  │
│  └───────────────┬─────────────────────────┘  │
│                  │                              │
│  ┌───────────────▼─────────────────────────┐  │
│  │    Utilities & Services                 │  │
│  │  - TF-IDF Engine                        │  │
│  │  - Hash Generation                      │  │
│  │  - Logging Service                      │  │
│  └───────────────┬─────────────────────────┘  │
│                  │                              │
│  ┌───────────────▼─────────────────────────┐  │
│  │    Models Layer (Mongoose)              │  │
│  │  - 17 Collections                       │  │
│  │  - Schema Validation                    │  │
│  │  - Relationships                        │  │
│  └───────────────┬─────────────────────────┘  │
└──────────────────┼──────────────────────────────┘
                   │ MongoDB Protocol
                   ▼
        MongoDB Atlas (Cloud)
        ├── Users
        ├── Documents
        ├── Chunks
        ├── TFIDFVector
        ├── SearchQueries
        ├── QueryFeedback
        └── ... (11 more collections)
```

## Directory Structure

```
dbms/
├── server.js                    # Main application entry
├── package.json                 # Dependencies
├── .env                         # Configuration (local)
├── .env.example                 # Configuration template
├── .gitignore                   # Git ignore rules
│
├── config/
│   └── database.js              # MongoDB connection
│
├── models/                      # Mongoose Schemas (17 files)
│   ├── User.js
│   ├── Document.js
│   ├── Chunk.js
│   ├── TFIDFVector.js
│   ├── SearchQuery.js
│   ├── QueryFeedback.js
│   └── ... (11 more models)
│
├── routes/                      # API Routes
│   ├── authRoutes.js            # /api/auth
│   ├── documentRoutes.js        # /api/documents
│   ├── searchRoutes.js          # /api/search
│   ├── feedbackRoutes.js        # /api/feedback
│   ├── analyticsRoutes.js       # /api/analytics
│   └── queryRoutes.js           # /api/query
│
├── controllers/                 # Business Logic
│   ├── authController.js        # Auth operations
│   ├── documentController.js    # Document CRUD
│   ├── searchController.js      # Search & Response
│   ├── feedbackController.js    # Feedback & Analytics
│   ├── analyticsController.js   # System Analytics
│   └── queryController.js       # Complex Queries
│
├── middleware/                  # Express Middleware
│   ├── auth.js                  # JWT verification
│   └── upload.js                # File upload handler
│
├── utils/                       # Utilities
│   ├── tfidf.js                # TF-IDF calculation
│   └── helpers.js               # Helper functions
│
├── uploads/                     # File storage
│
├── README.md                    # Project overview
├── DATABASE_SCHEMA.md           # DB documentation
├── API_TEST_GUIDE.md            # Testing guide
├── ARCHITECTURE.md              # This file
└── setup.sh                     # Setup script
```

## Request Flow

### 1. Document Upload Flow
```
Client Upload Request
    ↓
Routes → Middleware (auth, multer)
    ↓
Upload Controller
    ↓
Save Document Metadata
    ↓
Process File (read text)
    ↓
Tokenize & Create Chunks
    ↓
Calculate TF-IDF for each chunk
    ↓
Store in MongoDB Collections
    ↓
Return Success Response
```

### 2. Search Flow
```
Client Search Query
    ↓
Routes → Middleware (auth)
    ↓
Search Controller
    ↓
Check QueryCache
    ├─ Cache Hit → Return cached results
    └─ Cache Miss:
        ↓
        Tokenize query
        ↓
        Query TFIDFVector collection
        ↓
        Rank by score
        ↓
        Save SearchResults
        ↓
        Cache results
        ↓
        Return to client
```

### 3. Feedback Flow
```
User Feedback
    ↓
Routes → Middleware (auth)
    ↓
Feedback Controller
    ↓
Save QueryFeedback
    ↓
Update analytics
    ↓
Log action
    ↓
Return confirmation
```

## Key Components

### Authentication (JWT)
- User registers with username/email/password
- Password hashed with bcryptjs (salt rounds: 10)
- JWT token generated on login
- Token includes user ID and expiration
- Required for all protected endpoints

### Document Processing
- File upload via Multer
- Text extraction and tokenization
- Chunk creation (500 char default)
- TF-IDF vector calculation
- Data stored across multiple collections

### Search Engine (TF-IDF)
- Query tokenization
- Token lookup in TFIDFVector
- Score-based ranking
- Optional caching for performance
- Returns ranked chunks with source documents

### Feedback System
- 5-star rating system
- User comments
- Click tracking
- Dwell time measurement
- Analytics aggregation

### Analytics Engine
- System logging (all events)
- User session tracking
- Search query statistics
- Click analytics
- Storage metrics
- Error tracking

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Frontend | (To be added) |
| API Server | Node.js + Express.js |
| Authentication | JWT + bcryptjs |
| File Handling | Multer |
| Database | MongoDB Atlas |
| Schema Validation | Mongoose |
| Text Processing | Native JS |
| Logging | SystemLogs collection |
| Caching | MongoDB QueryCache |

## Performance Considerations

### Indexing
- All frequently queried fields have indexes
- Compound indexes for multi-field queries
- Descending order for sorting

### Query Optimization
- Use of lean() for read-only queries
- Pagination ready (limit/offset)
- Cache for repeated queries
- Aggregation pipeline for complex queries

### Scalability
- Stateless design (can run multiple instances)
- Database connection pooling
- File storage on disk
- Ready for CDN integration

## Security Features

1. **Authentication**
   - JWT tokens with expiration
   - Password hashing with bcryptjs

2. **Input Validation**
   - File type validation
   - File size limits (50MB)
   - Schema validation via Mongoose

3. **Error Handling**
   - Comprehensive logging
   - No sensitive data in responses
   - Try-catch blocks

4. **Future Enhancements**
   - Rate limiting
   - CORS configuration
   - Role-based access control
   - API key management

## Deployment Considerations

### Environment Variables
```
MONGODB_URI - MongoDB connection string
JWT_SECRET - Secret for signing tokens
JWT_EXPIRE - Token expiration time
PORT - Server port
NODE_ENV - Environment (development/production)
```

### Scaling Strategy
1. **Horizontal**: Run multiple server instances behind load balancer
2. **Vertical**: Increase server resources
3. **Database**: MongoDB Atlas auto-scaling
4. **Cache**: Redis integration (future)

### Monitoring
- SystemLogs collection tracks all events
- Error logging for debugging
- Query performance tracking
- Storage usage monitoring

## Future Enhancements

1. **LLM Integration**
   - Replace simple text concatenation with LLM
   - Support multiple models
   - Embeddings and vector search

2. **Advanced Search**
   - Full-text search with Elasticsearch
   - Semantic search with embeddings
   - Relevance feedback

3. **Frontend**
   - React/Vue UI
   - Real-time updates (WebSocket)
   - Advanced visualization

4. **Performance**
   - Redis caching layer
   - Elasticsearch integration
   - Database sharding

5. **Features**
   - User collaboration
   - Document versioning
   - Advanced permissions
   - Export features

## Related Documentation
- [README.md](./README.md) - Project overview
- [DATABASE_SCHEMA.md](./DATABASE_SCHEMA.md) - Database details
- [API_TEST_GUIDE.md](./API_TEST_GUIDE.md) - API testing
