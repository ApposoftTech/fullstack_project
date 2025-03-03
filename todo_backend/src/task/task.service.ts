import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Task } from './task.entity';

@Injectable()
export class TaskService {
  constructor(
    @InjectRepository(Task)
    private taskRepository: Repository<Task>,
  ) {}

/*   async findAll(): Promise<Task[]> {
    return this.taskRepository.find();
  } */

    async findAll(page: number = 1, limit: number = 10) {
      const [tasks, total] = await this.taskRepository.findAndCount({
        skip: (page - 1) * limit,
        take: limit,
        order: { created_at: 'DESC' },
      });
  
      return {
        totalCount: total,
        currentPage: page,
        totalPages: Math.ceil(total / limit),
        tasks,
      };
    }

  async findOne(id: string): Promise<Task> {
    const task = await this.taskRepository.findOne({ where: { id } });
    if (!task) throw new NotFoundException('Task not found');
    return task;
  }

  async create(taskData: Partial<Task>): Promise<Task> {
    const task = this.taskRepository.create(taskData);
    return this.taskRepository.save(task);
  }

  async update(id: string, taskData: Partial<Task>): Promise<Task> {
    await this.findOne(id);
    await this.taskRepository.update(id, taskData);

    const updatedTask = await this.taskRepository.findOne({ where: { id } });

    if (!updatedTask) {
      throw new NotFoundException(`Task with ID ${id} not found after update`);
    }
  
    return updatedTask;
  }

  async remove(id: string): Promise<void> {
    await this.findOne(id);
    await this.taskRepository.delete(id);
  }
}
