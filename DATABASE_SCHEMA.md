# Database Schema Documentation

## Collections Overview

This document provides detailed information about all MongoDB collections in the RAG search engine.

---

## 1. Users Collection

**Purpose**: Store user accounts and authentication information

```javascript
{
  _id: ObjectId,
  username: String (unique, required),
  email: String (unique, required),
  password: String (hashed, required),
  fullName: String,
  isActive: Boolean (default: true),
  createdAt: Date (default: now),
  updatedAt: Date (default: now)
}
```

**Indexes**:
- `username` (unique)
- `email` (unique)

---

## 2. Documents Collection

**Purpose**: Store document metadata and file information

```javascript
{
  _id: ObjectId,
  user_id: ObjectId (ref: User, required),
  doc_name: String (required),
  file_path: String (required),
  file_size: Number,
  file_type: String,
  language: String (enum: ['en', 'es', 'fr', 'de', 'ja', 'zh']),
  created_at: Date (default: now),
  updated_at: Date (default: now),
  is_processed: Boolean (default: false)
}
```

**Indexes**:
- `user_id & created_at` (compound)
- `language & created_at` (compound)

---

## 3. DocumentMetadata Collection

**Purpose**: Store categorized information about documents

```javascript
{
  _id: ObjectId,
  document_id: ObjectId (ref: Document, required, unique),
  category: String (enum: ['Technical', 'Business', 'Academic', 'Medical', 'Legal', 'Other']),
  author: String,
  description: String,
  tags: [String],
  source_url: String,
  created_at: Date (default: now)
}
```

**Indexes**:
- `document_id` (unique)
- `category`
- `author`

---

## 4. Chunks Collection

**Purpose**: Store text chunks of documents for processing

```javascript
{
  _id: ObjectId,
  document_id: ObjectId (ref: Document, required),
  chunk_index: Number (required),
  chunk_text: String (required),
  char_start: Number,
  char_end: Number,
  created_at: Date (default: now)
}
```

**Indexes**:
- `document_id & chunk_index` (compound)
- `document_id`

---

## 5. ChunkTokens Collection

**Purpose**: Map tokens to chunks for fast token-based lookups

```javascript
{
  _id: ObjectId,
  chunk_id: ObjectId (ref: Chunk, required),
  token: String (required),
  frequency: Number (default: 1),
  position: [Number],
  created_at: Date (default: now)
}
```

**Indexes**:
- `chunk_id & token` (compound)
- `token`

---

## 6. DocumentSummaries Collection

**Purpose**: Store auto-generated summaries (for future LLM integration)

```javascript
{
  _id: ObjectId,
  document_id: ObjectId (ref: Document, required, unique),
  summary_text: String (required),
  key_points: [String],
  created_at: Date (default: now)
}
```

**Indexes**:
- `document_id` (unique)

---

## 7. TFIDFVector Collection

**Purpose**: Store computed TF-IDF scores for tokens in chunks

```javascript
{
  _id: ObjectId,
  chunk_id: ObjectId (ref: Chunk, required),
  token: String (required),
  tf: Number (required),           // Term Frequency
  idf: Number (required),          // Inverse Document Frequency
  tf_idf_score: Number (required), // TF * IDF
  created_at: Date (default: now)
}
```

**Indexes**:
- `chunk_id & token` (compound)
- `token & tf_idf_score DESC` (compound, for ranking)
- `tf_idf_score DESC` (for global top scores)

---

## 8. VocabularyStats Collection

**Purpose**: Store global vocabulary statistics

```javascript
{
  _id: ObjectId,
  token: String (required, unique),
  document_frequency: Number (default: 0), // How many docs contain this token
  total_frequency: Number (default: 0),    // Total occurrences
  idf: Number (default: 0),                // Computed IDF
  created_at: Date (default: now),
  updated_at: Date (default: now)
}
```

**Indexes**:
- `token` (unique)
- `idf DESC`
- `document_frequency DESC`

---

## 9. UserSessions Collection

**Purpose**: Track user login/logout for analytics and security

```javascript
{
  _id: ObjectId,
  user_id: ObjectId (ref: User, required),
  ip_address: String,
  user_agent: String,
  login_time: Date (default: now),
  logout_time: Date,
  is_active: Boolean (default: true)
}
```

**Indexes**:
- `user_id & login_time DESC` (compound)
- `user_id & is_active` (compound)
- `ip_address`

---

## 10. SearchQueries Collection

**Purpose**: Track all search queries made by users

```javascript
{
  _id: ObjectId,
  user_id: ObjectId (ref: User, required),
  query_text: String (required),
  query_timestamp: Date (default: now),
  session_id: ObjectId (ref: UserSession),
  filters: {
    category: String,
    date_from: Date,
    date_to: Date
  }
}
```

**Indexes**:
- `user_id & query_timestamp DESC` (compound)
- `query_text`
- `query_timestamp DESC`

---

## 11. SearchResults Collection

**Purpose**: Store ranked results for each search query

```javascript
{
  _id: ObjectId,
  query_id: ObjectId (ref: SearchQuery, required),
  chunk_id: ObjectId (ref: Chunk, required),
  rank: Number,
  tf_idf_score: Number,
  relevance_score: Number,
  created_at: Date (default: now)
}
```

**Indexes**:
- `query_id & rank` (compound)
- `chunk_id`
- `query_id`

---

## 12. SearchClicks Collection

**Purpose**: Track which results users click on

```javascript
{
  _id: ObjectId,
  search_result_id: ObjectId (ref: SearchResult, required),
  user_id: ObjectId (ref: User, required),
  chunk_id: ObjectId (ref: Chunk, required),
  click_time: Date (default: now),
  click_position: Number,
  dwell_time: Number // milliseconds spent on result
}
```

**Indexes**:
- `search_result_id`
- `user_id & click_time DESC` (compound)
- `chunk_id`

---

## 13. GeneratedResponses Collection

**Purpose**: Store AI-generated responses (LLM integration ready)

```javascript
{
  _id: ObjectId,
  query_id: ObjectId (ref: SearchQuery, required),
  user_id: ObjectId (ref: User, required),
  response_text: String (required),
  response_timestamp: Date (default: now),
  is_cached: Boolean (default: false),
  model_used: String (default: 'tfidf') // Will change when LLM added
}
```

**Indexes**:
- `query_id`
- `user_id & response_timestamp DESC` (compound)

---

## 14. ResponseSource Collection

**Purpose**: Map source chunks to generated responses

```javascript
{
  _id: ObjectId,
  response_id: ObjectId (ref: GeneratedResponse, required),
  chunk_id: ObjectId (ref: Chunk, required),
  relevance_score: Number,
  created_at: Date (default: now)
}
```

**Indexes**:
- `response_id`
- `chunk_id`

---

## 15. QueryCache Collection

**Purpose**: Cache frequently searched queries for performance

```javascript
{
  _id: ObjectId,
  query_hash: String (required, unique), // MD5 hash of query_text
  query_text: String,
  user_id: ObjectId (ref: User),
  cached_response: Mixed, // Cached search results
  created_at: Date (default: now),
  updated_at: Date (default: now),
  hit_count: Number (default: 0) // How many times this cache was used
}
```

**Indexes**:
- `query_hash` (unique)
- `updated_at` (for purging old caches)

---

## 16. QueryFeedback Collection

**Purpose**: Store user feedback on search results

```javascript
{
  _id: ObjectId,
  query_id: ObjectId (ref: SearchQuery, required),
  user_id: ObjectId (ref: User, required),
  response_id: ObjectId (ref: GeneratedResponse),
  rating: Number (min: 1, max: 5, required),
  comment: String,
  feedback_timestamp: Date (default: now)
}
```

**Indexes**:
- `query_id`
- `user_id`
- `rating`
- `response_id`

---

## 17. SystemLogs Collection

**Purpose**: Audit trail and error logging

```javascript
{
  _id: ObjectId,
  user_id: ObjectId (ref: User),
  event_type: String (enum: ['Info', 'Warning', 'Error', 'Debug']),
  message: String,
  details: Mixed, // Additional context
  log_timestamp: Date (default: now),
  ip_address: String
}
```

**Indexes**:
- `event_type & log_timestamp DESC` (compound)
- `user_id & log_timestamp DESC` (compound)
- `log_timestamp DESC`

---

## Data Volume Guidelines

For a 3rd year DBMS project:

| Collection | Estimated Size |
|-----------|-----------------|
| Users | 50-200 |
| Documents | 500-2000 |
| Chunks | 50,000-200,000 |
| SearchQueries | 10,000-50,000 |
| ChunkTokens | 500,000-2,000,000 |
| TFIDFVector | 500,000-2,000,000 |
| VocabularyStats | 10,000-50,000 |
| SearchResults | 100,000-500,000 |

---

## Query Patterns

### High-Frequency Queries
1. Search by TF-IDF score - use compound index on `token & tf_idf_score`
2. Get user documents - use `user_id & created_at` index
3. Count chunks - indexed by `document_id`
4. Get session info - indexed by `user_id & is_active`

### Aggregation Patterns
1. Group by rating - use `rating` index for faster grouping
2. Sum frequencies - scan ChunkTokens with `token` index
3. Time-series analysis - use `timestamp` indexes

---

## Indexing Strategy

All indexes are created automatically by mongoose schemas. Use MongoDB Compass or Atlas UI to verify:

```javascript
// To check indexes in MongoDB shell
db.collection_name.getIndexes()
```

---

## Backup Strategy

For production, enable:
- MongoDB Atlas Automated Backups (daily)
- Point-in-time recovery
- Regular export to S3

---

## See Also
- [API_TEST_GUIDE.md](./API_TEST_GUIDE.md) - API endpoint testing
- [README.md](./README.md) - Project overview
