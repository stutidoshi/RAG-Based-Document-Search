# Quick Start Guide

## ⚡ Get Started in 5 Minutes

### 1. Prerequisites
```bash
# Check you have Node.js installed (v14 or higher)
node --version
npm --version

# You need:
- Node.js 14+
- npm 6+
- MongoDB Atlas account (free tier available)
```

### 2. Clone/Setup Project
```bash
cd /Users/kkk/dbms
# Project is already created, just update dependencies
npm install
```

### 3. Configure MongoDB
1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free cluster
3. Get connection string from "Connect" button
4. Update `.env` file:

```env
MONGODB_URI=mongodb+srv://your_username:your_password@cluster.mongodb.net/rag_search_engine?retryWrites=true&w=majority
JWT_SECRET=my_super_secret_key_12345
PORT=5000
NODE_ENV=development
```

### 4. Start Server
```bash
npm start
# Server runs on http://localhost:5000
```

### 5. Test API
```bash
# Health check
curl http://localhost:5000/api/health

# Register user
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123"
  }'
```

---

## 📚 Complete Project Structure

```
✅ 17 MongoDB Collections (all models created)
✅ 30+ API Endpoints
✅ 6 Controllers with business logic
✅ 6 Route modules
✅ Complete TF-IDF implementation
✅ JWT Authentication
✅ File Upload handler
✅ System logging
✅ Query caching
✅ Analytics engine
```

---

## 📁 What's Included

### Core Files
- ✅ `server.js` - Main application
- ✅ `package.json` - Dependencies
- ✅ `.env` - Configuration
- ✅ `config/database.js` - MongoDB connection

### Models (17 Collections)
- ✅ User
- ✅ Document
- ✅ DocumentMetadata
- ✅ Chunk
- ✅ ChunkToken
- ✅ DocumentSummary
- ✅ TFIDFVector
- ✅ VocabularyStats
- ✅ UserSession
- ✅ SearchQuery
- ✅ SearchResult
- ✅ SearchClick
- ✅ GeneratedResponse
- ✅ ResponseSource
- ✅ QueryCache
- ✅ QueryFeedback
- ✅ SystemLog

### Controllers (6)
- ✅ authController
- ✅ documentController
- ✅ searchController
- ✅ feedbackController
- ✅ analyticsController
- ✅ queryController

### Routes (6)
- ✅ `/api/auth` - Authentication
- ✅ `/api/documents` - Document management
- ✅ `/api/search` - Search and response generation
- ✅ `/api/feedback` - Feedback and ratings
- ✅ `/api/analytics` - System analytics
- ✅ `/api/query` - Advanced queries

---

## 🚀 API Endpoints Summary

### Authentication
```bash
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/logout
GET    /api/auth/profile
PUT    /api/auth/profile
```

### Documents
```bash
POST   /api/documents/upload
GET    /api/documents
GET    /api/documents/:id
DELETE /api/documents/:id
PUT    /api/documents/:id/metadata
GET    /api/documents/category/:category
```

### Search
```bash
POST   /api/search/query
GET    /api/search/history
POST   /api/search/click
POST   /api/search/response/generate
GET    /api/search/response/:id
```

### Feedback
```bash
POST   /api/feedback/submit
GET    /api/feedback/low-rated
GET    /api/feedback/top-clicked
GET    /api/feedback/by-rating
GET    /api/feedback/average-rank
GET    /api/feedback/summary
```

### Analytics
```bash
GET    /api/analytics/logs
GET    /api/analytics/stats
GET    /api/analytics/errors
GET    /api/analytics/events
GET    /api/analytics/queries-by-hour
GET    /api/analytics/orphans
DELETE /api/analytics/cache/purge
GET    /api/analytics/storage
```

### Advanced Queries (20+)
```bash
# Document & Chunk Management
GET /api/query/documents/user/:userId
GET /api/query/documents/:documentId/chunk-count
GET /api/query/documents/category/:category
GET /api/query/documents/:documentId/full-text
GET /api/query/documents/author/:author
GET /api/query/documents/without-summary
GET /api/query/documents/largest
GET /api/query/chunks/by-token/:token
GET /api/query/documents/language/:language

# TF-IDF & Search
GET /api/query/tfidf/:chunkId/:token
GET /api/query/tfidf/top/:token
GET /api/query/vocabulary/by-idf
GET /api/query/vocabulary/rarest
GET /api/query/tfidf/with-text/:token
GET /api/query/chunks/frequency/:token
GET /api/query/tfidf/average/:documentId
GET /api/query/vocabulary/common
GET /api/query/chunks/top-tokens/:chunkId
```

---

## 🧪 Quick Testing

### 1. Register & Login
```bash
# Register
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user1",
    "email": "user1@example.com",
    "password": "pass123"
  }'

# Login (you'll get a token)
TOKEN=$(curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user1@example.com",
    "password": "pass123"
  }' | jq -r '.token')

echo "Token: $TOKEN"
```

### 2. Upload Document
```bash
# Create a sample file
echo "This is a test document about machine learning. Machine learning is a subset of artificial intelligence." > sample.txt

# Upload
curl -X POST http://localhost:5000/api/documents/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@sample.txt" \
  -F "category=Technical" \
  -F "author=Test Author"
```

### 3. Search
```bash
curl -X POST http://localhost:5000/api/search/query \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "machine learning"
  }'
```

### 4. Submit Feedback
```bash
curl -X POST http://localhost:5000/api/feedback/submit \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query_id": "QUERY_ID_HERE",
    "rating": 5,
    "comment": "Excellent results!"
  }'
```

---

## 📖 Documentation Files

- **README.md** - Project overview and features
- **DATABASE_SCHEMA.md** - Detailed database structure
- **ARCHITECTURE.md** - System architecture and flow
- **API_TEST_GUIDE.md** - Complete API testing guide
- **setup.sh** - Automated setup script

---

## ⚙️ Development Commands

```bash
# Install dependencies
npm install

# Development mode (with auto-reload)
npm run dev

# Production mode
npm start

# View logs
tail -f .env

# Database connection test
node -e "require('./config/database').then(console.log)"
```

---

## 🔑 Environment Variables

```env
# Database
MONGODB_URI=your_mongodb_atlas_uri

# Authentication
JWT_SECRET=strong_secret_key_min_32_chars
JWT_EXPIRE=7d

# Server
PORT=5000
NODE_ENV=development

# File Upload
MAX_FILE_SIZE=50000000
UPLOAD_FOLDER=uploads/

# TF-IDF
MIN_DOCUMENT_FREQUENCY=2
MAX_DOCUMENT_FREQUENCY=0.8
```

---

## ✨ Key Features Implemented

### ✅ Authentication
- User registration with email validation
- Secure password hashing (bcryptjs)
- JWT token-based authentication
- Session tracking

### ✅ Document Management
- File upload with validation
- Automatic text processing and chunking
- Document metadata management
- Document categorization

### ✅ Search Engine
- TF-IDF based ranking
- Query tokenization
- Result ranking and sorting
- Query caching for performance

### ✅ Analytics
- Search query tracking
- Click tracking and analysis
- User session management
- Comprehensive system logging
- Storage statistics

### ✅ Feedback System
- 5-star rating system
- User comments
- Low-rated query identification
- Rating-based analytics

### ✅ Query Support
- All 30+ complex queries from requirements
- Document aggregation
- Token frequency analysis
- TF-IDF scoring queries
- User activity analysis

---

## 🚨 Important Notes

1. **Before first run**: Update MongoDB URI in `.env`
2. **Create uploads folder**: `mkdir -p uploads`
3. **Set strong JWT secret**: Generate a random string, don't use default
4. **CORS is enabled**: Ready for frontend integration
5. **File size limit**: 50MB per file (configurable in `.env`)
6. **Chunk size**: 500 characters (configurable in `utils/tfidf.js`)

---

## 🐛 Troubleshooting

### MongoDB Connection Error
```
✓ Check MONGODB_URI in .env
✓ Verify MongoDB Atlas IP whitelist (add 0.0.0.0/0 for development)
✓ Check username/password in connection string
✓ Ensure network connection works
```

### Port Already in Use
```
# Change PORT in .env or use:
PORT=5001 npm start
```

### File Upload Not Working
```
✓ Create uploads directory: mkdir -p uploads
✓ Check file permissions: chmod 755 uploads
✓ Verify file size < 50MB
✓ Check file type is allowed
```

---

## 📊 System Requirements

**Minimum**:
- 512 MB RAM
- 100 MB disk space
- Internet connection

**Recommended**:
- 2 GB RAM
- 1 GB disk space
- MongoDB Atlas (free tier)

---

## 🔄 Next Steps

1. ✅ Install dependencies: `npm install`
2. ✅ Configure MongoDB: Update `.env`
3. ✅ Start server: `npm start`
4. ✅ Test endpoints: Use curl or Postman
5. ⏳ Frontend: Integrate with React/Vue (later)
6. ⏳ LLM Integration: Add GPT/Gemini (later)

---

## 📞 Support

For issues:
1. Check `.env` configuration
2. Review system logs in MongoDB
3. Check MongoDB Atlas connection
4. Review error messages in terminal

---

**Created**: RAG Document Search Backend v1.0
**Status**: ✅ Production Ready for DBMS Project
**Next Phase**: Frontend Integration & LLM Enhancement
