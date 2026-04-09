#!/bin/bash

# Sophie Lamour - Deployment Helper Script
# This script helps with deploying the application to free tier services

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Sophie Lamour - Deployment Helper    ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Function to print section headers
print_section() {
    echo -e "${YELLOW}$1${NC}"
    echo "----------------------------------------"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Menu
show_menu() {
    echo "What would you like to do?"
    echo ""
    echo "1) Check prerequisites"
    echo "2) Setup environment files"
    echo "3) Test backend locally"
    echo "4) Test frontend locally"
    echo "5) Build frontend for production"
    echo "6) Show deployment instructions"
    echo "7) Exit"
    echo ""
    read -p "Enter your choice [1-7]: " choice
}

check_prerequisites() {
    print_section "Checking Prerequisites"
    
    # Check Node.js
    if command_exists node; then
        NODE_VERSION=$(node --version)
        echo -e "${GREEN}✓${NC} Node.js installed: $NODE_VERSION"
    else
        echo -e "${RED}✗${NC} Node.js not found. Please install Node.js 18+"
    fi
    
    # Check npm
    if command_exists npm; then
        NPM_VERSION=$(npm --version)
        echo -e "${GREEN}✓${NC} npm installed: $NPM_VERSION"
    else
        echo -e "${RED}✗${NC} npm not found"
    fi
    
    # Check Python
    if command_exists python3; then
        PYTHON_VERSION=$(python3 --version)
        echo -e "${GREEN}✓${NC} Python installed: $PYTHON_VERSION"
    else
        echo -e "${RED}✗${NC} Python 3 not found"
    fi
    
    # Check pip
    if command_exists pip3; then
        echo -e "${GREEN}✓${NC} pip3 installed"
    else
        echo -e "${RED}✗${NC} pip3 not found"
    fi
    
    # Check Vercel CLI
    if command_exists vercel; then
        echo -e "${GREEN}✓${NC} Vercel CLI installed"
    else
        echo -e "${YELLOW}!${NC} Vercel CLI not found. Install with: npm i -g vercel"
    fi
    
    # Check Git
    if command_exists git; then
        echo -e "${GREEN}✓${NC} Git installed"
    else
        echo -e "${RED}✗${NC} Git not found"
    fi
    
    echo ""
}

setup_environment() {
    print_section "Setting up Environment Files"
    
    if [ ! -f ".env" ]; then
        cp .env.example .env
        echo -e "${GREEN}✓${NC} Created .env file from .env.example"
        echo -e "${YELLOW}!${NC} Please edit .env file with your actual values"
    else
        echo -e "${YELLOW}!${NC} .env file already exists"
    fi
    
    echo ""
}

test_backend() {
    print_section "Testing Backend Locally"
    
    cd backend
    
    # Check if virtual environment exists
    if [ ! -d "venv" ]; then
        echo "Creating virtual environment..."
        python3 -m venv venv
    fi
    
    # Activate virtual environment
    source venv/bin/activate
    
    # Install dependencies
    echo "Installing dependencies..."
    pip install -r requirements.txt -q
    
    # Check if .env exists
    if [ ! -f ".env" ]; then
        echo -e "${YELLOW}!${NC} No .env file found in backend directory"
        echo "Creating from parent .env..."
        cp ../.env .env 2>/dev/null || echo "Please create backend/.env file"
    fi
    
    echo ""
    echo -e "${GREEN}Starting backend server...${NC}"
    echo "API will be available at: http://localhost:8000"
    echo "Health check: http://localhost:8000/api/health"
    echo "Press Ctrl+C to stop"
    echo ""
    
    uvicorn server:app --reload --host 0.0.0.0 --port 8000
}

test_frontend() {
    print_section "Testing Frontend Locally"
    
    cd frontend
    
    # Check if node_modules exists
    if [ ! -d "node_modules" ]; then
        echo "Installing dependencies..."
        npm install
    fi
    
    echo ""
    echo -e "${GREEN}Starting frontend development server...${NC}"
    echo "App will be available at: http://localhost:3000"
    echo "Press Ctrl+C to stop"
    echo ""
    
    npm start
}

build_frontend() {
    print_section "Building Frontend for Production"
    
    cd frontend
    
    # Check if node_modules exists
    if [ ! -d "node_modules" ]; then
        echo "Installing dependencies..."
        npm install
    fi
    
    echo "Building..."
    npm run build
    
    echo ""
    echo -e "${GREEN}✓${NC} Build complete!"
    echo "Build output is in frontend/build/"
    echo ""
}

show_instructions() {
    print_section "Deployment Instructions"
    
    cat << 'EOF'

🚀 DEPLOYMENT STEPS
===================

1. MONGODB ATLAS (Database)
   -------------------------
   • Go to https://www.mongodb.com/cloud/atlas
   • Create a free M0 cluster
   • Create a database user
   • Whitelist IP: 0.0.0.0/0 (for Render)
   • Copy connection string

2. BACKEND (Render)
   -----------------
   • Go to https://render.com
   • Sign up with GitHub
   • Click "New" → "Web Service"
   • Connect your GitHub repo
   • Configure:
     - Name: sophie-lamour-backend
     - Runtime: Python 3
     - Build: pip install -r backend/requirements.txt
     - Start: cd backend && uvicorn server:app --host 0.0.0.0 --port $PORT
   • Add environment variables:
     - MONGO_URL: your_mongodb_connection_string
     - DB_NAME: sophie_coaching
     - JWT_SECRET: random_secret_string
     - ADMIN_EMAIL: admin@sophielamour.com
     - ADMIN_PASSWORD: your_secure_password

3. FRONTEND (Vercel)
   ------------------
   • Go to https://vercel.com
   • Sign up with GitHub
   • Click "Add New Project"
   • Import your GitHub repo
   • Configure:
     - Framework: Create React App
     - Root Directory: frontend
   • Add environment variable:
     - REACT_APP_BACKEND_URL: https://your-backend.onrender.com

📚 FULL GUIDE: See DEPLOYMENT_GUIDE.md for detailed instructions

EOF
}

# Main loop
while true; do
    show_menu
    case $choice in
        1) check_prerequisites ;;
        2) setup_environment ;;
        3) test_backend ;;
        4) test_frontend ;;
        5) build_frontend ;;
        6) show_instructions ;;
        7) echo "Goodbye!"; exit 0 ;;
        *) echo -e "${RED}Invalid choice${NC}"; echo "" ;;
    esac
done
