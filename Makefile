# =====================================================
# 🚀 Makefile for Managing Kubernetes & Database 🚀
# =====================================================
#
# 👉 Available Commands:
#
# 🔹 Namespace Management:
#   make create-ns        → Create the Kubernetes namespace
#   make delete-ns        → Delete the Kubernetes namespace
#
# 🛢️ Database Management:
#   make run-database     → Deploy the database in Kubernetes
#   make delete-database  → Remove the database deployment
#
# 📦 Application Management:
#   make run-app          → Deploy the application in Kubernetes
#   make delete-app       → Remove the application deployment
#
# ⏳ Cron Job Management:
#   make run-job          → Deploy the scheduled job
#   make remove-job       → Remove the scheduled job
#
# 🔄 Port Forwarding:
#   make forward-app      → Forward port 3000 for the app
#   make forward-database → Forward port 5432 for the database
#
# 🛠️ Database Schema:
#   make schema-push      → Push the latest schema changes to DB
#
# 🚀 Full Deployment:
#   make run-all          → Waits for DB, forwards ports, pushes schema, then starts app
#
# 🧹 Cleanup:
#   make delete      	  → Delete everything (namespace, app, database)
#
# =====================================================

# 🏗️ Create Kubernetes namespace
create-ns:
	@echo "📌 Creating namespace..."
	kubectl apply -f namespace.yml
	@echo "✅ Namespace created successfully."

# 🗑️ Delete Kubernetes namespace
delete-ns:
	@echo "🗑️ Deleting namespace..."
	kubectl delete -f namespace.yml
	@echo "✅ Namespace deleted."

# 📦 Deploy Database
run-database: create-ns
	@echo "🚀 Deploying the database..."
	kubectl apply -f ./database
	@echo "✅ Database deployment started."

# ❌ Remove Database Deployment
delete-database:
	@echo "🗑️ Deleting the database..."
	kubectl delete -f ./database
	@echo "✅ Database deleted."

# 🚀 Deploy Application
run-app: create-ns
	@echo "🚀 Deploying the application..."
	kubectl apply -f ./app
	@echo "✅ Application deployment started."

# ❌ Remove Application Deployment
delete-app:
	@echo "🗑️ Deleting the application..."
	kubectl delete -f ./app
	@echo "✅ Application deleted."

# 🚀 Deploy Cron Job
run-job: create-ns
	@echo "📅 Deploying the Cron Job..."
	kubectl apply -f ./cron-job
	@echo "✅ Cron Job deployment started."

# ❌ Remove Cron Job
remove-job:
	@echo "🗑️ Deleting the Cron Job..."
	kubectl delete -f ./cron-job
	@echo "✅ Cron Job removed."

# 🗑️ Delete Everything (Namespace + App + Database)
delete:
	@echo "🗑️ Deleting everything..."
	kubectl delete -f namespace.yml
	@echo "✅ Everything is deleted."

# 🔄 Forward App Port (3000)
forward-app:
	@echo "🔄 Forwarding application port (3000)..."
	kubectl port-forward service/marketverse-svc 3000:3000 -n marketverse &
	@echo "✅ Application port forwarded."

# 🔄 Forward Database Port (5432)
forward-database:
	@echo "🔄 Forwarding database port (5432)..."
	kubectl port-forward service/database-service 5432:5432 -n marketverse &
	@echo "✅ Database port forwarded."

# 🛢️ Push the latest schema changes to the database
schema-push:
	@echo "📤 Pushing the latest schema changes..."
	pnpm exec drizzle-kit push
	@echo "✅ Schema successfully pushed."

# 🚀 Deploy everything in sequence with waiting logic
run-all: create-ns run-database 
	@echo "⏳ Waiting for database to be ready..."
	kubectl wait --for=condition=ready pod -l app=database -n marketverse --timeout=120s
	@echo "✅ Database is ready!"

	@echo "🔄 Forwarding database port..."
	@make forward-database
	
	@echo "📤 Pushing schema changes..."
	@make schema-push
	
	@echo "🚀 Deploying application..."
	@make run-app
	
	@echo "⏳ Waiting for application to be ready..."
	kubectl wait --for=condition=available deployment marketverse-dep -n marketverse --timeout=120s
	@echo "✅ Application is ready!"
	
	@echo "🔄 Forwarding application port..."
	@make forward-app
	
	@echo "📅 Deploying scheduled Cron Job..."
	@make run-job
	
	@echo "🚀 Marketverse is up and running!"
