import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Enable Swagger
  const config = new DocumentBuilder()
  .setTitle('To-Do List API')
  .setDescription('API documentation for the To-Do List application')
  .setVersion('1.0')
  .addTag('tasks')
  .build();
  
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
