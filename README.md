# RAG-Based Smart Document Search Engine - Backend

A production-ready backend for a RAG (Retrieval-Augmented Generation) based intelligent document search engine with TF-IDF core logic, user authentication, and comprehensive analytics.

## Features

- **User Authentication**: Secure login/registration with JWT tokens
- **Document Management**: Upload, process, and manage documents
- **TF-IDF Search**: Intelligent document search using TF-IDF algorithm
- **Search Analytics**: Comprehensive search and click tracking
- **Feedback System**: User ratings and feedback on search results
- **System Logging**: Complete audit trail and error tracking
- **Query Caching**: Intelligent caching for frequently searched queries
- **Multiple Query Endpoints**: ~30+ specialized query endpoints for advanced analytics

## Tech Stack

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB Atlas
- **Authentication**: JWT
- **File Upload**: Multer
- **Validation**: Express-Validator

## Installation

1. Clone the repository:
```bash
git clone <repo-url>
cd dbms
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file from `.env.example`:
```bash
cp .env.example .env
```

4. Update `.env` with your MongoDB Atlas credentials:
```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/rag_search_engine?retryWrites=true&w=majority
JWT_SECRET=your_secret_key_here
PORT=5000
```

5. Start the server:
```bash
npm start
```

For development with auto-reload:
```bash
npm run dev
```

## API Endpoints

### Authentication (`/api/auth`)
- `POST /register` - Register new user
- `POST /login` - User login
- `POST /logout` - User logout
- `GET /profile` - Get user profile
- `PUT /profile` - Update user profile

### Documents (`/api/documents`)
- `POST /upload` - Upload document
- `GET /` - Get user's documents
- `GET /:documentId` - Get document details
- `DELETE /:documentId` - Delete document
- `PUT /:documentId/metadata` - Update document metadata
- `GET /category/:category` - Get documents by category

### Search (`/api/search`)
- `POST /query` - Search documents
- `GET /history` - Get search history
- `POST /click` - Record click on result
- `POST /response/generate` - Generate response from chunks
- `GET /response/:responseId` - Get response with sources

### Feedback (`/api/feedback`)
- `POST /submit` - Submit feedback
- `GET /low-rated` - Get low-rated queries
- `GET /top-clicked` - Get most clicked chunks
- `GET /by-rating` - Group feedback by rating
- `GET /average-rank` - Calculate average rank of clicked results
- `GET /summary` - Get analytics summary

### Analytics (`/api/analytics`)
- `GET /logs` - Get system logs
- `GET /stats` - Get system statistics
- `GET /errors` - Get error logs
- `GET /events` - Get event statistics
- `GET /queries-by-hour` - Get queries per hour
- `GET /orphans` - Identify orphan records
- `DELETE /cache/purge` - Purge old cache entries
- `GET /storage` - Get storage statistics

### Advanced Queries (`/api/query`)

**Document Management**:
- `GET /documents/user/:userId` - Get documents by user
- `GET /documents/:documentId/chunk-count` - Count chunks
- `GET /documents/category/:category` - Get by category
- `GET /documents/:documentId/full-text` - Get full text
- `GET /documents/author/:author` - Get by author
- `GET /documents/without-summary` - Docs without summary
- `GET /documents/largest` - Top 5 largest docs
- `GET /chunks/by-token/:token` - Get chunks with token
- `GET /documents/language/:language` - Get by language

**TF-IDF & Search**:
- `GET /tfidf/:chunkId/:token` - Get TF-IDF score
- `GET /tfidf/top/:token` - Top chunks by token
- `GET /vocabulary/by-idf` - Tokens above IDF threshold
- `GET /vocabulary/rarest` - Rarest tokens
- `GET /tfidf/with-text/:token` - TF-IDF with content
- `GET /chunks/frequency/:token` - Chunks by frequency
- `GET /tfidf/average/:documentId` - Average TF-IDF
- `GET /vocabulary/common` - Common tokens (stopwords)
- `GET /chunks/top-tokens/:chunkId` - Top tokens in chunk

## Database Collections

1. **Users** - User accounts
2. **Documents** - Document metadata
3. **DocumentMetadata** - Document categorization
4. **Chunks** - Text chunks from documents
5. **ChunkTokens** - Tokens in chunks
6. **DocumentSummaries** - Auto-generated summaries
7. **TFIDFVector** - TF-IDF scores
8. **VocabularyStats** - Global vocabulary statistics
9. **UserSessions** - User session tracking
10. **SearchQueries** - Search queries
11. **SearchResults** - Search results with ranks
12. **SearchClicks** - User clicks on results
13. **GeneratedResponses** - AI-generated responses
14. **ResponseSource** - Sources for responses
15. **QueryCache** - Cached search results
16. **QueryFeedback** - User feedback on results
17. **SystemLogs** - System events and errors

## Query Scenarios Supported

✅ Retrieve all documents uploaded by a specific user_id
✅ Count the total number of chunks associated with a specific document_id
✅ List all documents belonging to a specific category
✅ Retrieve the full text of a document by aggregating all chunks
✅ Find all documents authored by a specific person
✅ Identify documents without summaries
✅ Retrieve the top 5 documents with highest number of chunks
✅ Find all chunks containing a specific token
✅ Filter documents by language
✅ Update document category
✅ Retrieve TF-IDF scores for specific tokens
✅ Find top chunks by search tokens
✅ Get tokens by IDF threshold
✅ Get rarest tokens in system
✅ Join TF-IDF with chunk content
✅ Find chunks with token frequency > threshold
✅ Calculate average TF-IDF per document
✅ Identify similar content by high-scoring tokens
✅ List potential stopwords
✅ Get top tokens per chunk
✅ Get search queries in last 24 hours
✅ Count active sessions
✅ Find most active user
✅ Find users who uploaded but never searched
✅ Get user IP address history
✅ Calculate session duration
✅ Find new users with 10+ searches
✅ Group queries by frequency
✅ Get response sources and context
✅ Find influential documents
✅ Get cache hit analysis
✅ Find most common document for user
✅ Get low-rated queries
✅ Calculate average rating by category
✅ Analyze clicks vs initial rank
✅ Get top clicked chunks
✅ Correlate TF-IDF with user ratings
✅ Qualitative feedback analysis
✅ Calculate average rank of clicked results
✅ Identify high-rated documents
✅ Get error logs
✅ Find frequent events
✅ Identify orphan records
✅ Purge old cache
✅ Calculate storage distribution

## Development Notes

- All user operations are authenticated via JWT tokens
- File uploads are validated and stored in `/uploads` directory
- TF-IDF calculation is performed automatically on document upload
- System logs all operations for audit trails
- Cache improves performance for repeated queries
- LLM integration can be added later in the GeneratedResponse model

## Future Enhancements

- [ ] LLM/Vector embedding integration
- [ ] Advanced semantic search
- [ ] Multi-language support improvements
- [ ] Full-text search with Elasticsearch
- [ ] WebSocket for real-time updates
- [ ] Rate limiting and throttling
- [ ] Advanced permission system

## License

MIT

## Support

For issues and questions, please create an issue in the repository.
