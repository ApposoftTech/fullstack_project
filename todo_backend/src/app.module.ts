import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TaskModule } from './task/task.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [
    ConfigModule.forRoot({isGlobal: true}),
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
    AuthModule,
  ],
})
export class AppModule {}
