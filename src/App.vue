<template>
  <div id="app">
    <h1>إدارة المهام</h1>

    <div class="task-form">
      <input v-model="newTask.name" placeholder="أدخل اسم المهمة" />
      <select v-model="newTask.priority">
        <option value="عالي">عالي</option>
        <option value="متوسط">متوسط</option>
        <option value="منخفض">منخفض</option>
      </select>
      <input v-model="newTask.dueDate" type="date" />
      <button class="btn-add" @click="addTask">إضافة المهمة</button>
    </div>

    <div class="search">
      <input v-model="searchQuery" placeholder="ابحث عن مهمة..." />
      <button class="btn-search" @click="searchTask">بحث</button>
    </div>

    <div class="filters">
      <button :class="{ active: filter === 'all' }" @click="setFilter('all')">عرض الكل</button>
      <button :class="{ active: filter === 'completed' }" @click="setFilter('completed')">عرض المكتملة</button>
      <button :class="{ active: filter === 'notCompleted' }" @click="setFilter('notCompleted')">عرض غير المكتملة</button>
    </div>

    <div class="task-list">
      <ul>
        <li v-for="task in filteredTasks" :key="task.id">
          <span :class="task.isCompleted ? 'completed' : ''">
            {{ task.name }} - {{ task.priority }} - {{ task.dueDate }}
          </span>
          <div class="task-actions">
            <button @click="toggleStatus(task.id)">تبديل الحالة</button>
            <button @click="editTask(task)">تعديل</button>
            <button @click="deleteTask(task.id)">حذف</button>
          </div>
        </li>
      </ul>
    </div>

    <!-- تعديل المهمة مودال -->
    <div v-if="editingTask" class="modal-overlay">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">تعديل المهمة</h5>
          <button @click="cancelEdit">&times;</button>
        </div>
        <div class="modal-body">
          <input v-model="editingTask.name" placeholder="أدخل اسم المهمة" class="form-control" />
          <select v-model="editingTask.priority" class="form-control mt-2">
            <option value="عالي">عالي</option>
            <option value="متوسط">متوسط</option>
            <option value="منخفض">منخفض</option>
          </select>
          <input v-model="editingTask.dueDate" type="date" class="form-control mt-2" />
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="cancelEdit">إلغاء</button>
          <button class="btn btn-primary" @click="saveEdit">حفظ التعديلات</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tasks: [],
      newTask: { name: '', priority: 'عالي', dueDate: '', isCompleted: false },
      nextId: 1,
      filter: 'all',
      searchQuery: '',
      editingTask: null
    };
  },
  methods: {
    addTask() {
      if (this.newTask.name.trim() !== '') {
        this.tasks.push({
          id: this.nextId++,
          name: this.newTask.name,
          priority: this.newTask.priority,
          dueDate: this.newTask.dueDate,
          isCompleted: false
        });
        this.newTask = { name: '', priority: 'عالي', dueDate: '', isCompleted: false };
      }
    },
    deleteTask(id) {
      this.tasks = this.tasks.filter(task => task.id !== id);
    },
    toggleStatus(id) {
      const task = this.tasks.find(task => task.id === id);
      if (task) task.isCompleted = !task.isCompleted;
    },
    setFilter(status) {
      this.filter = status;
    },
    editTask(task) {
      this.editingTask = { ...task };
    },
    saveEdit() {
      const index = this.tasks.findIndex(task => task.id === this.editingTask.id);
      if (index !== -1) {
        this.tasks[index] = { ...this.editingTask };
        this.editingTask = null;
      }
    },
    cancelEdit() {
      this.editingTask = null;
    },
    searchTask() {
      // البحث يتم من خلال computed filteredTasks
    }
  },
  computed: {
    filteredTasks() {
      let tasks = this.tasks;

      if (this.filter === 'completed') tasks = tasks.filter(task => task.isCompleted);
      else if (this.filter === 'notCompleted') tasks = tasks.filter(task => !task.isCompleted);

      if (this.searchQuery) {
        tasks = tasks.filter(task =>
          task.name.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
      }

      return tasks;
    }
  }
};
</script>

<style>
body {
  font-family: 'Roboto', sans-serif;
  background: linear-gradient(135deg, #f18cc0, #9181ff);
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  margin: 0;
}

h1 {
  font-family: 'Pacifico', cursive;
  color: white;
  font-size: 2.8em;
  margin-bottom: 30px;
  text-align: center;
}

.task-form {
  background: linear-gradient(135deg, #ff66b2, #4c6ef5);
  padding: 30px;
  border-radius: 25px;
  max-width: 400px;
  margin: auto;
}

.task-form input,
.task-form select {
  width: 100%;
  padding: 14px;
  margin: 10px 0;
  border-radius: 15px;
  border: none;
  font-size: 1.1em;
}

.task-form input[type="date"] {
  background-color: #f0f1f9;
}

.btn-add {
  width: 100%;
  padding: 14px;
  border-radius: 15px;
  border: none;
  font-size: 1.2em;
  color: white;
  background-color: #ff3385;
  cursor: pointer;
}

.btn-add:hover {
  background-color: #e60073;
}

.search {
  display: flex;
  max-width: 400px;
  margin: 15px auto;
}

.search input {
  flex: 1;
  padding: 12px;
  border-radius: 15px 0 0 15px;
  border: none;
}

.btn-search {
  padding: 12px 20px;
  border-radius: 0 15px 15px 0;
  border: none;
  background-color: #ff3385;
  color: white;
  cursor: pointer;
}

.btn-search:hover {
  background-color: #e60073;
}

.filters {
  display: flex;
  justify-content: space-between;
  max-width: 400px;
  margin: 20px auto;
}

.filters button {
  flex: 1;
  margin: 0 5px;
  padding: 12px;
  border-radius: 20px;
  border: none;
  font-size: 1em;
  color: white;
  cursor: pointer;
  background-color: #ff66b2;
}

.filters button.active {
  background-color: #7f7fff;
}

.task-list {
  max-width: 400px;
  margin: 20px auto;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  display: flex;
  justify-content: space-between;
  padding: 12px;
  background: linear-gradient(135deg, #ff66b2, #4c6ef5);
  border-radius: 20px;
  margin-bottom: 10px;
  color: white;
}

.completed {
  text-decoration: line-through;
}

.task-actions button {
  margin-left: 5px;
  padding: 5px 10px;
  border-radius: 15px;
  border: none;
  cursor: pointer;
  background-color: #3498db;
  color: white;
}

.task-actions button:hover {
  background-color: #2980b9;
}

/* Modal */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.7);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 15px;
  width: 90%;
  max-width: 400px;
}

.modal-header button {
  background: none;
  border: none;
  font-size: 1.5em;
  float: right;
  cursor: pointer;
}
</style>
