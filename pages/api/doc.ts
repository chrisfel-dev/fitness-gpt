import { withSwagger } from 'next-swagger-doc';

/**
 * @swagger
 * /api/doc:
 *   get:
 *     description: Returns the Swagger docs for all APIs exposed by fitness gpt
 *     responses:
 *       200:
 *         description: Swagger docs for all APIs exposed by fitness gpt
 */
const swaggerHandler = withSwagger({
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'FitnessGPT',
      version: '0.1.0',
    },
  },
  apiFolder: 'pages/api',
});
export default swaggerHandler();