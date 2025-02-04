Fastapi encourages models (ORM classes that map to actual database tables) and schemas (define what data is expected, returned, etc. by certain API endpoints for request to be considered valid).

```
.
├── alembic
│   └── versions
├── app
│   ├── api
│   │   └── v1
│   │       └── endpoints
│   ├── crud
│   ├── models
│   └── schemas
└── tests
```