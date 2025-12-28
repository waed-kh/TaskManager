# -----------------------------
# مرحلة البناء
# -----------------------------
FROM node:20-alpine AS build-stage
WORKDIR /app

# نسخ ملفات المشروع الأساسية لتثبيت الـ dependencies
COPY package*.json ./
RUN npm install

# نسخ كل ملفات المشروع
COPY . .
RUN npm run build

# -----------------------------
# مرحلة التشغيل (Production)
# -----------------------------
FROM nginx:alpine AS production-stage

# نسخ الملفات المبنية من مرحلة البناء
COPY --from=build-stage /app/dist /usr/share/nginx/html

# فتح البورت 80 داخل الحاوية
EXPOSE 80

# Healthcheck: تأكد إن الصفحة الرئيسية ترد
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost || exit 1

# بدء Nginx
CMD ["nginx", "-g", "daemon off;"]














































# Makefile لإدارة Docker لمشروع Task Manager

# اسم الصورة
IMAGE_NAME = taskmanager-vue
# بورت التطبيق
PORT = 5174
# اسم الحاوية
CONTAINER_NAME = taskmanager-app

# -----------------------------
# بناء الصورة
# -----------------------------
build:
	docker build -t $(IMAGE_NAME) .

# -----------------------------
# تشغيل الحاوية
# -----------------------------
run:
	docker run -d -p $(PORT):80 --name $(CONTAINER_NAME) $(IMAGE_NAME)

# -----------------------------
# إيقاف الحاوية
# -----------------------------
stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# -----------------------------
# إعادة البناء والتشغيل بسرعة
# -----------------------------
rebuild: stop build run

# -----------------------------
# حالة الحاوية
# -----------------------------
status:
	docker ps -a | grep $(CONTAINER_NAME)
