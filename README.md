# Sophie Lamour - Coaching Website

A beautiful coaching website built with React (frontend) and FastAPI (backend).

## 🚀 Deployment

This repository is configured for free tier deployment:

| Service | Purpose | Cost |
|---------|---------|------|
| [Vercel](https://vercel.com) | Frontend Hosting | Free |
| [Render](https://render.com) | Backend API | Free |
| [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) | Database | Free |

## 📁 Project Structure

```
.
├── frontend/          # React application
├── backend/           # FastAPI application
├── vercel.json        # Vercel config
├── render.yaml        # Render config
└── DEPLOYMENT_GUIDE.md  # Detailed instructions
```

## 🛠️ Quick Deploy

### 1. MongoDB Atlas
1. Create free cluster at [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
2. Get your connection string
3. Whitelist IP: `0.0.0.0/0`

### 2. Render (Backend)
1. Connect this repo to [Render](https://render.com)
2. Create Web Service with:
   - Build: `pip install -r backend/requirements.txt`
   - Start: `cd backend && uvicorn server:app --host 0.0.0.0 --port $PORT`
3. Add environment variables (see `.env.example`)

### 3. Vercel (Frontend)
1. Connect this repo to [Vercel](https://vercel.com)
2. Set root directory: `frontend`
3. Add `REACT_APP_BACKEND_URL` = your Render URL

## 📖 Full Guide

See [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for detailed instructions.

## 📝 Environment Variables

### Backend (Render)
- `MONGO_URL` - MongoDB connection string
- `DB_NAME` - Database name
- `JWT_SECRET` - JWT secret key
- `ADMIN_EMAIL` - Admin login email
- `ADMIN_PASSWORD` - Admin password

### Frontend (Vercel)
- `REACT_APP_BACKEND_URL` - Backend API URL
