# API Testing Guide

This file contains curl commands to test all endpoints. Make sure the server is running on `http://localhost:5000`

## Authentication Endpoints

### 1. Register a New User
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "fullName": "Test User"
  }'
```

### 2. Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

### 3. Get Profile
```bash
curl -X GET http://localhost:5000/api/auth/profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 4. Update Profile
```bash
curl -X PUT http://localhost:5000/api/auth/profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Updated Name"
  }'
```

### 5. Logout
```bash
curl -X POST http://localhost:5000/api/auth/logout \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Document Endpoints

### 1. Upload Document
```bash
curl -X POST http://localhost:5000/api/documents/upload \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "file=@/path/to/document.txt" \
  -F "category=Technical" \
  -F "author=John Doe" \
  -F "description=Sample document"
```

### 2. Get All User Documents
```bash
curl -X GET http://localhost:5000/api/documents \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 3. Get Document by ID
```bash
curl -X GET http://localhost:5000/api/documents/DOCUMENT_ID \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 4. Get Documents by Category
```bash
curl -X GET "http://localhost:5000/api/documents/category/Technical" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 5. Update Document Metadata
```bash
curl -X PUT http://localhost:5000/api/documents/DOCUMENT_ID/metadata \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "category": "Business",
    "author": "Jane Doe"
  }'
```

### 6. Delete Document
```bash
curl -X DELETE http://localhost:5000/api/documents/DOCUMENT_ID \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Search Endpoints

### 1. Search Documents
```bash
curl -X POST http://localhost:5000/api/search/query \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "machine learning algorithm",
    "filters": {
      "category": "Technical"
    }
  }'
```

### 2. Get Search History (Last 24 Hours)
```bash
curl -X GET "http://localhost:5000/api/search/history?hours=24" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 3. Record Click on Search Result
```bash
curl -X POST http://localhost:5000/api/search/click \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "search_result_id": "RESULT_ID",
    "chunk_id": "CHUNK_ID",
    "dwell_time": 5000
  }'
```

### 4. Generate Response from Chunks
```bash
curl -X POST http://localhost:5000/api/search/response/generate \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "query_id": "QUERY_ID",
    "chunk_ids": ["CHUNK_ID_1", "CHUNK_ID_2"]
  }'
```

### 5. Get Response with Sources
```bash
curl -X GET http://localhost:5000/api/search/response/RESPONSE_ID \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Feedback Endpoints

### 1. Submit Feedback
```bash
curl -X POST http://localhost:5000/api/feedback/submit \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "query_id": "QUERY_ID",
    "response_id": "RESPONSE_ID",
    "rating": 5,
    "comment": "Very helpful results!"
  }'
```

### 2. Get Low-Rated Queries (Rating < 3)
```bash
curl -X GET "http://localhost:5000/api/feedback/low-rated?threshold=3" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 3. Get Top Clicked Chunks
```bash
curl -X GET "http://localhost:5000/api/feedback/top-clicked?limit=10" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 4. Get Feedback by Rating
```bash
curl -X GET http://localhost:5000/api/feedback/by-rating \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 5. Get Average Click Rank
```bash
curl -X GET http://localhost:5000/api/feedback/average-rank \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 6. Get Analytics Summary
```bash
curl -X GET http://localhost:5000/api/feedback/summary \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Analytics Endpoints

### 1. Get System Logs
```bash
curl -X GET "http://localhost:5000/api/analytics/logs?event_type=Error&hours=24" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### 2. Get System Stats
```bash
curl -X GET http://localhost:5000/api/analytics/stats
```

### 3. Get Error Logs (Last 24 Hours)
```bash
curl -X GET "http://localhost:5000/api/analytics/errors?hours=24"
```

### 4. Get Event Statistics (Last 7 Days)
```bash
curl -X GET "http://localhost:5000/api/analytics/events?hours=168"
```

### 5. Get Queries by Hour (Last 24 Hours)
```bash
curl -X GET "http://localhost:5000/api/analytics/queries-by-hour?hours=24"
```

### 6. Identify Orphan Records
```bash
curl -X GET http://localhost:5000/api/analytics/orphans
```

### 7. Purge Cache (Older than 30 days)
```bash
curl -X DELETE "http://localhost:5000/api/analytics/cache/purge?days=30"
```

### 8. Get Storage Statistics
```bash
curl -X GET http://localhost:5000/api/analytics/storage
```

## Advanced Query Endpoints

### Document Management Queries

#### 1. Get Documents by User
```bash
curl -X GET http://localhost:5000/api/query/documents/user/USER_ID
```

#### 2. Get Chunk Count by Document
```bash
curl -X GET http://localhost:5000/api/query/documents/DOCUMENT_ID/chunk-count
```

#### 3. Get Documents by Category
```bash
curl -X GET http://localhost:5000/api/query/documents/category/Technical
```

#### 4. Get Full Document Text
```bash
curl -X GET http://localhost:5000/api/query/documents/DOCUMENT_ID/full-text
```

#### 5. Get Documents by Author
```bash
curl -X GET http://localhost:5000/api/query/documents/author/John%20Doe
```

#### 6. Get Documents Without Summary
```bash
curl -X GET http://localhost:5000/api/query/documents/without-summary
```

#### 7. Get Top Largest Documents
```bash
curl -X GET "http://localhost:5000/api/query/documents/largest?limit=5"
```

#### 8. Get Chunks by Token
```bash
curl -X GET http://localhost:5000/api/query/chunks/by-token/machine
```

#### 9. Get Documents by Language
```bash
curl -X GET http://localhost:5000/api/query/documents/language/en
```

### TF-IDF & Search Queries

#### 1. Get TF-IDF Score
```bash
curl -X GET http://localhost:5000/api/query/tfidf/CHUNK_ID/token_name
```

#### 2. Get Top Chunks by Token
```bash
curl -X GET "http://localhost:5000/api/query/tfidf/top/machine?limit=10"
```

#### 3. Get Tokens by IDF Threshold
```bash
curl -X GET "http://localhost:5000/api/query/vocabulary/by-idf?threshold=0.5"
```

#### 4. Get Rarest Tokens
```bash
curl -X GET "http://localhost:5000/api/query/vocabulary/rarest?limit=10"
```

#### 5. Get TF-IDF with Text Content
```bash
curl -X GET "http://localhost:5000/api/query/tfidf/with-text/machine?limit=10"
```

#### 6. Get Chunks by Frequency
```bash
curl -X GET "http://localhost:5000/api/query/chunks/frequency/machine?min_frequency=5"
```

#### 7. Get Average TF-IDF for Document
```bash
curl -X GET http://localhost:5000/api/query/tfidf/average/DOCUMENT_ID
```

#### 8. Get Common Tokens (Potential Stopwords)
```bash
curl -X GET "http://localhost:5000/api/query/vocabulary/common?threshold=0.5"
```

#### 9. Get Top Tokens in Chunk
```bash
curl -X GET "http://localhost:5000/api/query/chunks/top-tokens/CHUNK_ID?limit=5"
```

## Health Check

```bash
curl -X GET http://localhost:5000/api/health
```

## Notes

- Replace `YOUR_TOKEN_HERE` with the JWT token received from login
- Replace `DOCUMENT_ID`, `CHUNK_ID`, `QUERY_ID`, etc. with actual IDs from your database
- All authenticated endpoints require the `Authorization: Bearer TOKEN` header
- File upload requires multipart form data
