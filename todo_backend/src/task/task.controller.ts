import { Controller, Get, Post, Put, Delete, Param, Body } from '@nestjs/common';
import { TaskService } from './task.service';
import { Task } from './task.entity';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBody } from '@nestjs/swagger';

@ApiTags('tasks') // Grouping under "tasks"
@Controller('tasks')
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Get()
  @ApiOperation({ summary: 'Retrieve all tasks' })
  @ApiResponse({ status: 200, description: 'Returns an array of tasks.' })
  findAll(): Promise<Task[]> {
    return this.taskService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Retrieve a specific task by ID' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiResponse({ status: 200, description: 'Returns the task.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  findOne(@Param('id') id: string): Promise<Task> {
    return this.taskService.findOne(id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new task' })
  @ApiBody({ type: Task, description: 'Task object to be created' })
  @ApiResponse({ status: 201, description: 'Task successfully created.' })
  create(@Body() taskData: Partial<Task>): Promise<Task> {
    return this.taskService.create(taskData);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update an existing task' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiBody({ type: Task, description: 'Updated task object' })
  @ApiResponse({ status: 200, description: 'Task successfully updated.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  update(@Param('id') id: string, @Body() taskData: Partial<Task>): Promise<Task> {
    return this.taskService.update(id, taskData);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a task' })
  @ApiParam({ name: 'id', description: 'Task ID' })
  @ApiResponse({ status: 200, description: 'Task successfully deleted.' })
  @ApiResponse({ status: 404, description: 'Task not found.' })
  remove(@Param('id') id: string): Promise<void> {
    return this.taskService.remove(id);
  }
}
