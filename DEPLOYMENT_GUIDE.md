# Sophie Lamour - Free Tier Deployment Guide

This guide will help you migrate your website from Emergent hosting to free tier services.

## Architecture Overview

```
┌─────────────────┐      ┌──────────────────┐      ┌─────────────────┐
│   Vercel        │──────▶   Render         │──────▶  MongoDB Atlas  │
│  (Frontend)     │      │  (Backend API)   │      │   (Database)    │
└─────────────────┘      └──────────────────┘      └─────────────────┘
     Free Tier                Free Tier                 Free Tier
     (React App)              (Python/FastAPI)          (512MB)
```

## Step 1: Set Up MongoDB Atlas (Free Database)

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) and create a free account
2. Create a new cluster (M0 - Free Tier)
3. Configure database access:
   - Create a database user with password
   - Add your IP to the Network Access whitelist (or allow from anywhere `0.0.0.0/0` for Render)
4. Get your connection string:
   - Click "Connect" → "Drivers" → "Python"
   - Copy the connection string, replacing `<password>` with your actual password
   - Example: `mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/sophie_coaching?retryWrites=true&w=majority`

## Step 2: Deploy Backend to Render (Free)

1. Go to [Render](https://render.com) and sign up with GitHub
2. Click "New" → "Blueprint" (or "Web Service" for manual setup)
3. Connect your GitHub repository
4. Configure the service:
   - **Name**: `sophie-lamour-backend`
   - **Runtime**: Python 3
   - **Build Command**: `pip install -r backend/requirements.txt`
   - **Start Command**: `cd backend && uvicorn server:app --host 0.0.0.0 --port $PORT`
   - **Plan**: Free

5. Add Environment Variables:
   ```
   MONGO_URL=mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/sophie_coaching?retryWrites=true&w=majority
   DB_NAME=sophie_coaching
   JWT_SECRET=your-super-secret-random-string-here
   ADMIN_EMAIL=admin@sophielamour.com
   ADMIN_PASSWORD=YourSecurePassword123!
   ```

6. Click "Create Web Service"
7. Wait for deployment and note your backend URL (e.g., `https://sophie-lamour-backend.onrender.com`)

## Step 3: Deploy Frontend to Vercel (Free)

### Option A: Using Vercel CLI (Recommended)

1. Install Vercel CLI:
   ```bash
   npm i -g vercel
   ```

2. Login to Vercel:
   ```bash
   vercel login
   ```

3. Deploy from the frontend directory:
   ```bash
   cd frontend
   vercel --prod
   ```

4. Set environment variable in Vercel Dashboard:
   - Go to your project settings
   - Add `REACT_APP_BACKEND_URL` = `https://your-backend-url.onrender.com`

### Option B: Using GitHub Integration

1. Push your code to GitHub
2. Go to [Vercel](https://vercel.com) and sign up with GitHub
3. Click "Add New Project"
4. Import your GitHub repository
5. Configure:
   - **Framework Preset**: Create React App
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`
6. Add Environment Variable:
   - `REACT_APP_BACKEND_URL` = `https://your-backend-url.onrender.com`
7. Click "Deploy"

## Step 4: Update CORS in Backend

After deployment, update the CORS origins in `backend/server.py` to allow your Vercel domain:

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://your-frontend.vercel.app",  # Your Vercel URL
        "http://localhost:3000",              # Local development
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

Then redeploy the backend on Render.

## Environment Variables Summary

### Backend (Render)
| Variable | Description | Example |
|----------|-------------|---------|
| `MONGO_URL` | MongoDB connection string | `mongodb+srv://...` |
| `DB_NAME` | Database name | `sophie_coaching` |
| `JWT_SECRET` | Secret for JWT tokens | Random string |
| `ADMIN_EMAIL` | Admin login email | `admin@sophielamour.com` |
| `ADMIN_PASSWORD` | Admin password | `YourPassword123!` |

### Frontend (Vercel)
| Variable | Description | Example |
|----------|-------------|---------|
| `REACT_APP_BACKEND_URL` | Backend API URL | `https://sophie-lamour-backend.onrender.com` |

## Free Tier Limits

### Vercel (Frontend)
- **Bandwidth**: 100GB/month
- **Builds**: 6000 minutes/month
- **Team Members**: 1

### Render (Backend)
- **Instance**: Spins down after 15 min of inactivity (cold start ~30s)
- **Bandwidth**: 100GB/month
- **Builds**: 500 minutes/month
- **Disk**: Ephemeral (resets on deploy)

### MongoDB Atlas
- **Storage**: 512MB
- **Connections**: 500 concurrent
- **Data Transfer**: 10GB in/out per week

## Troubleshooting

### Backend shows "Not Found"
- Check that all environment variables are set correctly
- Verify MongoDB IP whitelist includes Render's IPs
- Check Render logs for connection errors

### Frontend can't connect to backend
- Verify `REACT_APP_BACKEND_URL` is set correctly
- Check CORS configuration in backend
- Ensure backend is deployed and running

### Images not loading
- Images are stored in MongoDB as base64
- Check that uploads collection exists in MongoDB
- Verify file size limits (50MB max)

### Admin login not working
- Check that admin user was created (see startup logs)
- Verify JWT_SECRET is set
- Clear browser cookies and try again

## Local Development

1. Copy `.env.example` to `.env` and fill in values
2. Start MongoDB locally or use Atlas
3. Run backend:
   ```bash
   cd backend
   pip install -r requirements.txt
   uvicorn server:app --reload
   ```
4. Run frontend:
   ```bash
   cd frontend
   npm install
   npm start
   ```

## Migration Checklist

- [ ] MongoDB Atlas cluster created
- [ ] Database user created
- [ ] Network access configured
- [ ] Backend deployed to Render
- [ ] Frontend deployed to Vercel
- [ ] Environment variables configured
- [ ] CORS updated with production domain
- [ ] Admin login tested
- [ ] Blog posts migrated (if any)
- [ ] Images uploaded (if any)
- [ ] Contact form tested
- [ ] Custom domain configured (optional)

## Support

- **Render Docs**: https://render.com/docs
- **Vercel Docs**: https://vercel.com/docs
- **MongoDB Atlas Docs**: https://docs.atlas.mongodb.com/
