import swaggerJsdoc from 'swagger-jsdoc';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Australian Polo Backend API',
      version: '1.0.0',
      description: 'REST API for the Australian Polo mobile application',
      contact: {
        name: 'API Support',
      },
    },
    servers: [
      {
        url: 'http://localhost:3000',
        description: 'Development server',
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
      schemas: {
        Error: {
          type: 'object',
          properties: {
            status: {
              type: 'string',
              example: 'error',
            },
            message: {
              type: 'string',
              example: 'Error message',
            },
          },
        },
        Tournament: {
          type: 'object',
          properties: {
            id: {
              type: 'integer',
              example: 1,
            },
            name: {
              type: 'string',
              example: 'Australian Open Polo Championship',
            },
            location: {
              type: 'string',
              example: 'Sydney',
            },
            start_date: {
              type: 'string',
              format: 'date',
              nullable: true,
              example: '2025-01-15',
            },
            end_date: {
              type: 'string',
              format: 'date',
              nullable: true,
              example: '2025-01-20',
            },
          },
        },
        TournamentInput: {
          type: 'object',
          required: ['name', 'location'],
          properties: {
            name: {
              type: 'string',
              minLength: 2,
              maxLength: 200,
              example: 'Australian Open Polo Championship',
            },
            location: {
              type: 'string',
              maxLength: 200,
              example: 'Sydney',
            },
            start_date: {
              type: 'string',
              format: 'date',
              nullable: true,
              example: '2025-01-15',
            },
            end_date: {
              type: 'string',
              format: 'date',
              nullable: true,
              example: '2025-01-20',
            },
          },
        },
        User: {
          type: 'object',
          properties: {
            id: {
              type: 'integer',
              example: 1,
            },
            name: {
              type: 'string',
              example: 'John Doe',
            },
            email: {
              type: 'string',
              format: 'email',
              example: 'john@example.com',
            },
          },
        },
        RegisterInput: {
          type: 'object',
          required: ['name', 'email', 'password'],
          properties: {
            name: {
              type: 'string',
              minLength: 2,
              maxLength: 100,
              example: 'John Doe',
            },
            email: {
              type: 'string',
              format: 'email',
              example: 'john@example.com',
            },
            password: {
              type: 'string',
              minLength: 6,
              example: 'Password123',
              description: 'Must contain at least one uppercase, lowercase, and number',
            },
          },
        },
        LoginInput: {
          type: 'object',
          required: ['email', 'password'],
          properties: {
            email: {
              type: 'string',
              format: 'email',
              example: 'john@example.com',
            },
            password: {
              type: 'string',
              example: 'Password123',
            },
          },
        },
        AuthResponse: {
          type: 'object',
          properties: {
            user: {
              $ref: '#/components/schemas/User',
            },
            token: {
              type: 'string',
              example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
            },
          },
        },
      },
    },
  },
  apis: [join(__dirname, '..', 'routes', '*.js')],
};

export const swaggerSpec = swaggerJsdoc(options);
