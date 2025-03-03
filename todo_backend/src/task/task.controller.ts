import { Controller, Get, Post, Put, Delete, Param, Body, UseGuards, Req } from '@nestjs/common';
import { TaskService } from './task.service';
import { Task } from './task.entity';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBody, ApiBearerAuth } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt_auth.guard';

@ApiTags('tasks')
@ApiBearerAuth() 
@Controller('tasks')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Get()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Retrieve all tasks (Auth Required)' })
  @ApiResponse({ status: 200, description: 'Returns an array of tasks.' })
  findAll(@Req() req): Promise<Task[]> {
    console.log('Authenticated User:', req.user);
    return this.taskService.findAll();
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Retrieve a specific task by ID (Auth Required)' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiResponse({ status: 200, description: 'Returns the task.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  findOne(@Param('id') id: string, @Req() req): Promise<Task> {
    console.log('Authenticated User:', req.user);
    return this.taskService.findOne(id);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Create a new task (Auth Required)' })
  @ApiBody({ type: Task, description: 'Task object to be created' })
  @ApiResponse({ status: 201, description: 'Task successfully created.' })
  create(@Body() taskData: Partial<Task>, @Req() req): Promise<Task> {
    console.log('Authenticated User:', req.user);
    return this.taskService.create(taskData);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard) 
  @ApiOperation({ summary: 'Update an existing task (Auth Required)' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiBody({ type: Task, description: 'Updated task object' })
  @ApiResponse({ status: 200, description: 'Task successfully updated.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  update(@Param('id') id: string, @Body() taskData: Partial<Task>, @Req() req): Promise<Task> {
    console.log('Authenticated User:', req.user);
    return this.taskService.update(id, taskData);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Delete a task (Auth Required)' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiResponse({ status: 200, description: 'Task successfully deleted.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  remove(@Param('id') id: string, @Req() req): Promise<void> {
    console.log('Authenticated User:', req.user);
    return this.taskService.remove(id);
  }
}
