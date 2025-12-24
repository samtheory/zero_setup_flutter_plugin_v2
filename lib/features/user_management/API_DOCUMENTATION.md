# API Documentation - User Management Feature

This document describes the expected API contract for the user management feature.

## Base Configuration

```
Base URL: http://localhost:3080
Content-Type: application/json
Accept: application/json
```

## Authentication

If your API requires authentication, add headers in the Dio provider:

```dart
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
      return handler.next(options);
    },
  ),
);
```

---

## Endpoints

### 1. Get Current User

Retrieves the authenticated user's profile and wallet information.

**Endpoint:** `GET /me`

**Headers:**
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {token}  // If using auth
```

**Response: 200 OK**

```json
{
  "id": 445,
  "name": "Ali",
  "lastName": "Ahmadi",
  "nationalCode": "1234567890",
  "mobile": "+989121234567",
  "email": "ali.ahmadi@example.com",
  "status": "ACTIVE",
  "createdAt": "2024-01-15T10:45:32Z",
  "wallets": [
    {
      "id": 101,
      "companyId": 12,
      "employeeId": 445,
      "balance": 325000,
      "title": "Main Wallet",
      "transactionLimit": 500000,
      "feePercentForNormal": 2,
      "feePercentForFast": 5,
      "suspended": false
    },
    {
      "id": 102,
      "companyId": 12,
      "employeeId": 445,
      "balance": 125000,
      "title": "Bonus Wallet",
      "transactionLimit": 200000,
      "feePercentForNormal": 1,
      "feePercentForFast": 3,
      "suspended": false
    }
  ]
}
```

**Response: 401 Unauthorized**

```json
{
  "message": "Unauthorized access",
  "statusCode": 401
}
```

**Response: 404 Not Found**

```json
{
  "message": "User not found",
  "statusCode": 404
}
```

---

### 2. Update User Profile

Updates the current user's profile information. Only provided fields will be updated.

**Endpoint:** `PATCH /me`

**Headers:**
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {token}  // If using auth
```

**Request Body:**

All fields are optional. Only include fields you want to update.

```json
{
  "name": "NewFirstName",
  "lastName": "NewLastName",
  "email": "newemail@example.com",
  "mobile": "+989129999999",
  "nationalCode": "0987654321"
}
```

**Response: 200 OK**

Returns the complete updated user object (same structure as GET /me):

```json
{
  "id": 445,
  "name": "NewFirstName",
  "lastName": "NewLastName",
  "nationalCode": "0987654321",
  "mobile": "+989129999999",
  "email": "newemail@example.com",
  "status": "ACTIVE",
  "createdAt": "2024-01-15T10:45:32Z",
  "wallets": [...]
}
```

**Response: 400 Bad Request**

```json
{
  "message": "Validation failed",
  "errors": [
    {
      "field": "email",
      "message": "Invalid email format"
    }
  ],
  "statusCode": 400
}
```

**Response: 409 Conflict**

```json
{
  "message": "Email already exists",
  "statusCode": 409
}
```

---

### 3. Update Wallet Balance

Updates a wallet's balance by adding income or recording an expense.

**Endpoint:** `PATCH /wallets/{walletId}/balance`

**Path Parameters:**
- `walletId` (integer, required): The ID of the wallet to update

**Headers:**
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {token}  // If using auth
```

**Request Body:**

```json
{
  "amount": 50000,
  "type": "income",
  "description": "Monthly salary deposit"
}
```

**Request Fields:**
- `amount` (number, required): Transaction amount (positive number)
- `type` (string, required): Transaction type - either `"income"` or `"expense"`
- `description` (string, optional): Description of the transaction

**Response: 200 OK**

Returns the updated wallet object:

```json
{
  "id": 101,
  "companyId": 12,
  "employeeId": 445,
  "balance": 375000,
  "title": "Main Wallet",
  "transactionLimit": 500000,
  "feePercentForNormal": 2,
  "feePercentForFast": 5,
  "suspended": false
}
```

**Response: 400 Bad Request**

```json
{
  "message": "Insufficient balance for expense",
  "statusCode": 400
}
```

**Response: 403 Forbidden**

```json
{
  "message": "Wallet is suspended. Transactions not allowed.",
  "statusCode": 403
}
```

**Response: 404 Not Found**

```json
{
  "message": "Wallet not found",
  "statusCode": 404
}
```

---

## Data Models

### User Object

```typescript
{
  id: number;              // Unique user identifier
  name: string;            // First name
  lastName: string;        // Last name
  nationalCode: string;    // National ID number
  mobile: string;          // Phone number (international format)
  email: string;           // Email address
  status: string;          // User status: "ACTIVE", "INACTIVE", "SUSPENDED", "PENDING"
  createdAt: string;       // ISO 8601 datetime (e.g., "2024-01-15T10:45:32Z")
  wallets: Wallet[];       // Array of wallet objects
}
```

### Wallet Object

```typescript
{
  id: number;                  // Unique wallet identifier
  companyId: number;           // Company identifier
  employeeId: number;          // Employee/user identifier
  balance: number;             // Current balance (in smallest currency unit)
  title: string;               // Wallet display name
  transactionLimit: number;    // Maximum amount per transaction
  feePercentForNormal: number; // Fee percentage for normal transactions
  feePercentForFast: number;   // Fee percentage for fast transactions
  suspended: boolean;          // Whether wallet is blocked/suspended
}
```

---

## Sample API Requests

### Using cURL

**Get Current User:**
```bash
curl -X GET http://localhost:3080/me \
  -H "Content-Type: application/json" \
  -H "Accept: application/json"
```

**Update User Profile:**
```bash
curl -X PATCH http://localhost:3080/me \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "Ali",
    "email": "ali.updated@example.com"
  }'
```

**Add Income to Wallet:**
```bash
curl -X PATCH http://localhost:3080/wallets/101/balance \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "amount": 50000,
    "type": "income",
    "description": "Salary"
  }'
```

**Add Expense to Wallet:**
```bash
curl -X PATCH http://localhost:3080/wallets/101/balance \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "amount": 10000,
    "type": "expense",
    "description": "Purchase"
  }'
```

---

## Error Handling

All errors follow this structure:

```json
{
  "message": "Human-readable error message",
  "statusCode": 400,
  "errors": [
    {
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

### Common HTTP Status Codes

- `200 OK`: Request successful
- `400 Bad Request`: Invalid request data or validation error
- `401 Unauthorized`: Authentication required or failed
- `403 Forbidden`: User doesn't have permission
- `404 Not Found`: Resource doesn't exist
- `409 Conflict`: Resource conflict (e.g., duplicate email)
- `422 Unprocessable Entity`: Semantic validation failed
- `500 Internal Server Error`: Server error

---

## Alternative API Design

If your API uses different endpoints, you can modify the datasource implementation:

### Option 1: RESTful with separate endpoints

```dart
// In user_remote_datasource.dart

// Update to PUT instead of PATCH
final response = await dio.put(_meEndpoint, data: updates);

// Wallet endpoint at different path
final response = await dio.post(
  '/transactions',
  data: {
    'walletId': walletId,
    'amount': amount,
    'type': transactionType,
  },
);
```

### Option 2: GraphQL

If using GraphQL, replace the datasource entirely:

```dart
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final GraphQLClient client;
  
  @override
  Future<UserModel> fetchCurrentUser() async {
    final result = await client.query(QueryOptions(
      document: gql('''
        query GetMe {
          me {
            id name lastName email wallets { id balance }
          }
        }
      '''),
    ));
    
    return UserModel.fromJson(result.data!['me']);
  }
}
```

---

## Testing the API

### Postman Collection

Create a Postman collection with these requests:

1. **Get User**
   - Method: GET
   - URL: `{{baseUrl}}/me`

2. **Update User**
   - Method: PATCH
   - URL: `{{baseUrl}}/me`
   - Body: JSON with user fields

3. **Update Wallet**
   - Method: PATCH
   - URL: `{{baseUrl}}/wallets/{{walletId}}/balance`
   - Body: JSON with amount, type, description

### Mock Server

For development without a backend, you can use:

1. **json-server** (Node.js)
2. **Mockoon**
3. **Postman Mock Server**

Example db.json for json-server:

```json
{
  "me": {
    "id": 445,
    "name": "Ali",
    "lastName": "Ahmadi",
    "nationalCode": "1234567890",
    "mobile": "+989121234567",
    "email": "ali.ahmadi@example.com",
    "status": "ACTIVE",
    "createdAt": "2024-01-15T10:45:32Z",
    "wallets": [
      {
        "id": 101,
        "companyId": 12,
        "employeeId": 445,
        "balance": 325000,
        "title": "Main Wallet",
        "transactionLimit": 500000,
        "feePercentForNormal": 2,
        "feePercentForFast": 5,
        "suspended": false
      }
    ]
  }
}
```

---

## Rate Limiting

If your API implements rate limiting, handle it in the repository:

```dart
Exception _handleDioError(DioException error) {
  if (error.response?.statusCode == 429) {
    return Exception('Too many requests. Please try again later.');
  }
  // ... other error handling
}
```

---

## Versioning

If using API versioning:

```dart
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3080/api/v1',  // Add version
      headers: {
        'Accept': 'application/vnd.myapi.v1+json',
      },
    ),
  );
});
```

---

## Questions?

If you need to customize the API integration:

1. Check the datasource implementation
2. Modify the endpoint URLs
3. Adjust request/response transformations
4. Update error handling as needed

The architecture is designed to make API changes easy - just update the datasource layer!
