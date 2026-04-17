Importing Postman collection (Auth + Upload + Search)

1) Files added to repo:
- postman_collection_search.json
- postman_env.json

2) Import into Postman
- Open Postman → Import → Choose File → select `postman_collection_search.json` and `postman_env.json`.
- Select the imported environment (`RAG Backend Local`) and ensure `baseUrl` is `http://localhost:3001`.

3) Use the flow
- Run `Register` to create a user.
- Run `Login (save token)` — this test will save `authToken` and `userId` to the environment.
- Use `Upload Document` (choose a local file in the request body `file` field) to upload a document; `Authorization` header is set from environment.
- Run `Search` with queries like `test document` to find uploaded content.
- Use `Get Profile` and `Logout` as needed.

Notes
- `category` must be one of: Technical, Business, Academic, Medical, Legal, Other.
- If your server uses a different port, update `baseUrl` in the environment file.
