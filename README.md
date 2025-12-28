# Vue 3 + Vite

This template should help get you started developing with Vue 3 in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

Learn more about IDE Support for Vue in the [Vue Docs Scaling up Guide](https://vuejs.org/guide/scaling-up/tooling.html#ide-support).
# Task Manager

تطبيق إدارة المهام باستخدام Vue.js وVite

## Tech Stack
- Vue.js 3
- Vite
- NPM
- Nginx (Docker)

## Docker
### Build & Run
```bash
docker build -t taskmanager-vue .
docker run -p 5174:80 taskmanager-vue

docker ps          # لمعرفة رقم الحاوية
docker stop <id>
docker rm <id>



> بهذا الشكل، README.md جاهز ويحتوي كل المعلومات المطلوبة للواجب:  
> - كيفية بناء وتشغيل Docker  
> - كيفية إيقاف وإزالة الحاوية  
> - اختبار التطبيق  
> - مصدر المشروع (Attribution)  

إذا تحب، أقدر أجهز لك **النسخة الكاملة لكل ملفات المشروع الجاهزة للنسخ مباشرة** مع Dockerfile و.gitignore و.dockerignore وdocs/screenshots وnotes.md، بحيث ترفع كل شيء على GitHub مباشرة بعد اختبار Docker.  

هل تريد أن أفعل هذا الآن؟



> بهذا الشكل، README.md جاهز تمامًا للواجب: Docker، تشغيل، إيقاف الحاوية، اختبار التطبيق، ومصدر المشروع.

---

لو تحب، أقدر أجهز لك **كل الملفات الأخرى النهائية جاهزة للنسخ مباشرة** (Dockerfile، .gitignore، .dockerignore، docs/screenshots فارغ، notes.md) بحيث ترفع المشروع على GitHub مباشرة بعد اختبار Docker.  

هل تريد أن أفعل هذا الآن؟
