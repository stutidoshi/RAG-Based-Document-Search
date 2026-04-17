#!/bin/bash

# RAG Backend Setup Script

echo "🚀 RAG Document Search Backend Setup"
echo "===================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 14 or higher."
    exit 1
fi

echo "✅ Node.js version: $(node -v)"
echo "✅ NPM version: $(npm -v)"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Create .env if it doesn't exist
if [ ! -f .env ]; then
    echo ""
    echo "📝 Creating .env file..."
    cp .env.example .env
    echo "⚠️  Please update .env with your MongoDB Atlas credentials"
fi

# Create uploads directory
if [ ! -d uploads ]; then
    echo ""
    echo "📁 Creating uploads directory..."
    mkdir -p uploads
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update .env with your MongoDB Atlas connection string"
echo "2. Run 'npm start' to start the server"
echo "3. Server will run on http://localhost:5000"
echo ""
echo "For development with auto-reload, run: npm run dev"
