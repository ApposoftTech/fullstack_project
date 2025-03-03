import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TaskModule } from './task/task.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT!) || 5432,
      username: process.env.DB_USER || 'todo_user',
      password: process.env.DB_PASS || 'todo_password',
      database: process.env.DB_NAME || 'todo_database',
      autoLoadEntities: true,
      synchronize: true,
    }),
    TaskModule,
  ],
})
export class AppModule {}
