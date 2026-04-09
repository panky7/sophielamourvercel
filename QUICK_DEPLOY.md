# 🚀 QUICK DEPLOYMENT GUIDE - Sophie Lamour

Follow these exact steps to deploy your website for FREE!

---

## STEP 1: Deploy Backend to Render (5 minutes)

### Option A: Using Render Blueprint (EASIEST - Click only!)

1. **Click this magic button:**

   👉 https://render.com/deploy?repo=https://github.com/panky7/sophielamourvercel

2. **Sign in with GitHub** if not already signed in

3. **Fill in the Environment Variables:**

   | Variable | What to enter |
   |----------|---------------|
   | `MONGO_URL` | Your MongoDB connection string (see Step 0 below) |
   | `ADMIN_EMAIL` | `admin@sophielamour.com` |
   | `ADMIN_PASSWORD` | Choose a secure password |

4. **Click "Apply"** - Done! Render will deploy automatically.

---

### Option B: Manual Setup (if Blueprint doesn't work)

1. Go to https://dashboard.render.com

2. Click **"New +"** → **"Web Service"**

3. **Connect your GitHub repository:**
   - Find and select `panky7/sophielamourvercel`
   - Click **"Connect"**

4. **Configure the service:**

   | Setting | Value |
   |---------|-------|
   | Name | `sophie-lamour-backend` |
   | Region | `Oregon (US West)` |
   | Branch | `main` |
   | Root Directory | `backend` ⚠️ IMPORTANT! |
   | Runtime | `Python 3` |
   | Build Command | `pip install -r requirements.txt` |
   | Start Command | `uvicorn server:app --host 0.0.0.0 --port $PORT` |
   | Plan | `Free` |

5. Click **"Create Web Service"**

6. **Add Environment Variables** (click "Environment" tab):

   Click **"Add Environment Variable"** for each:

   ```
   MONGO_URL=mongodb+srv://your_username:your_password@cluster.mongodb.net/sophie_coaching?retryWrites=true&w=majority
   DB_NAME=sophie_coaching
   JWT_SECRET=any-random-secret-string-here
   ADMIN_EMAIL=admin@sophielamour.com
   ADMIN_PASSWORD=YourSecurePassword123!
   ```

7. Click **"Save Changes"** then **"Manual Deploy"** → **"Deploy latest commit"**

---

## STEP 0: Get MongoDB Connection String (Do this first!)

1. Go to https://www.mongodb.com/cloud/atlas
2. Sign up / Log in
3. Click **"Build a Cluster"** → Choose **"M0 (FREE)"**
4. Click **"Create Cluster"**
5. Create a **Database User**:
   - Username: `sophie_admin`
   - Password: Create a strong password
   - Click **"Create User"**
6. Add **IP Whitelist**:
   - Click **"Add IP Address"**
   - Click **"Allow Access from Anywhere"** (0.0.0.0/0)
   - Click **"Confirm"**
7. Click **"Connect"** → **"Connect your application"**
8. Copy the connection string (looks like):
   ```
   mongodb+srv://sophie_admin:<password>@cluster0.xxxxx.mongodb.net/sophie_coaching?retryWrites=true&w=majority
   ```
9. **Replace `<password>` with your actual password**

---

## STEP 2: Deploy Frontend to Vercel (3 minutes)

### One-Click Deploy (EASIEST)

1. **Click this magic button:**

   👉 https://vercel.com/new/clone?repository-url=https://github.com/panky7/sophielamourvercel&root-directory=frontend&env=REACT_APP_BACKEND_URL

2. **Sign in with GitHub**

3. **Configure:**
   - Project Name: `sophie-lamour-frontend`
   - Framework Preset: `Create React App`
   - Root Directory: `frontend` (should be pre-filled)
   - Environment Variable:
     - `REACT_APP_BACKEND_URL` = `https://sophie-lamour-backend.onrender.com`
       (Replace with your actual Render URL)

4. Click **"Deploy"** - Done!

---

### Manual Setup

1. Go to https://vercel.com/dashboard

2. Click **"Add New..."** → **"Project"**

3. **Import your GitHub repository:**
   - Find `panky7/sophielamourvercel`
   - Click **"Import"**

4. **Configure:**

   | Setting | Value |
   |---------|-------|
   | Framework Preset | `Create React App` |
   | Root Directory | `frontend` |
   | Build Command | `npm run build` (default) |
   | Output Directory | `build` (default) |

5. Click **"Environment Variables"** and add:
   ```
   REACT_APP_BACKEND_URL=https://sophie-lamour-backend.onrender.com
   ```
   ⚠️ Use your actual Render URL!

6. Click **"Deploy"**

---

## STEP 3: Verify Everything Works

### Test Backend:
Open: `https://sophie-lamour-backend.onrender.com/api/health`

Should show: `{"status": "healthy", "service": "sophie-lamour-backend"}`

### Test Frontend:
Open your Vercel URL (e.g., `https://sophie-lamour-frontend.vercel.app`)

### Test Admin Login:
1. Go to `https://your-vercel-url.vercel.app/admin/login`
2. Login with:
   - Email: `admin@sophielamour.com`
   - Password: (the one you set in Render)

---

## 🎉 DONE!

Your website is now live on FREE hosting!

| Service | URL | Cost |
|---------|-----|------|
| Backend | `https://sophie-lamour-backend.onrender.com` | FREE |
| Frontend | `https://sophie-lamour-frontend.vercel.app` | FREE |
| Database | MongoDB Atlas | FREE |

---

## 🔧 Troubleshooting

### "Build failed" on Render?
- Check Root Directory is set to `backend`
- Check `MONGO_URL` is correct

### "Cannot connect to backend" on Vercel?
- Verify `REACT_APP_BACKEND_URL` matches your Render URL exactly
- Make sure backend is deployed and running

### Admin login not working?
- Check `ADMIN_EMAIL` and `ADMIN_PASSWORD` in Render environment variables
- Clear browser cookies and try again

---

## 📞 Need Help?

- Render Docs: https://render.com/docs
- Vercel Docs: https://vercel.com/docs
- MongoDB Atlas Docs: https://docs.atlas.mongodb.com/
