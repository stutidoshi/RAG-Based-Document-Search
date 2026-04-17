# 🆓 HuggingFace Setup Guide (Completely Free)

## Why HuggingFace?
- ✅ **Completely FREE** - No billing needed
- ✅ **Multiple models** - Choose from many open models
- ✅ **Fast inference** - Powered by HuggingFace servers
- ✅ **No rate limits** - On free tier
- ✅ **Easy setup** - Just API key needed

---

## 📋 Step 1: Create HuggingFace Account

1. Go to: **https://huggingface.co/join**
2. Sign up with email or GitHub
3. Verify your email
4. ✅ Account created!

---

## 🔑 Step 2: Get Your API Key

1. Go to: **https://huggingface.co/settings/tokens**
2. Click **"New token"**
3. Give it a name (e.g., "DBMS RAG")
4. Type: **"Read"** (not write)
5. Click **"Generate token"**
6. Copy your token (starts with `hf_`)

**⚠️ IMPORTANT**: Save this token somewhere safe!

---

## 🤖 Step 3: Choose a Model

Popular open models on HuggingFace:

### Option A: Mistral 7B (Recommended - Fastest)
```
Model: mistralai/Mistral-7B-Instruct-v0.1
Speed: ⚡ Fast
Quality: ⭐⭐⭐⭐
Memory: ~15GB
```

### Option B: Llama 2 (Best Quality)
```
Model: meta-llama/Llama-2-7b-chat-hf
Speed: ⚠️ Medium
Quality: ⭐⭐⭐⭐⭐
Memory: ~13GB
```

### Option C: Neural Chat (Balanced)
```
Model: Intel/neural-chat-7b-v3-1
Speed: ⚡ Fast
Quality: ⭐⭐⭐⭐
Memory: ~14GB
```

---

## 📝 Step 4: Setup Your Project

### Option A: Interactive Setup
```bash
chmod +x /Users/kkk/dbms/scripts/setupHuggingFace.js
node /Users/kkk/dbms/scripts/setupHuggingFace.js
```

Then paste your API key when prompted.

### Option B: Manual Setup

1. Open `/Users/kkk/dbms/.env`

2. Find these lines:
```env
HUGGINGFACE_API_KEY=your_huggingface_api_key_here
HUGGINGFACE_MODEL=mistralai/Mistral-7B-Instruct-v0.1
```

3. Replace with your actual key:
```env
HUGGINGFACE_API_KEY=hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxx
HUGGINGFACE_MODEL=mistralai/Mistral-7B-Instruct-v0.1
```

4. Save the file

---

## 🚀 Step 5: Test It

```bash
# 1. Stop any running server
pkill -f "npm" || true

# 2. Clear old database
node scripts/clearDatabase.js

# 3. Start fresh server
npm start

# 4. In another terminal, run CLI
node scripts/interactiveSearch.js
```

Then search for: **"who teaches dbms"**

Expected response:
```
════════════════════════════════════════════════════════════════════════════════
🤖 LLM GENERATED ANSWER
════════════════════════════════════════════════════════════════════════════════

Dr. Asha teaches Database Management Systems (DBMS).
```

---

## 🆘 Troubleshooting

### Error: "API token not authenticated"
- ✅ Check token starts with `hf_`
- ✅ Token must be "Read" type
- ✅ Regenerate new token if needed

### Error: "Model not found"
- ✅ Make sure model name is correct
- ✅ Visit https://huggingface.co/models to verify
- ✅ Try Mistral: `mistralai/Mistral-7B-Instruct-v0.1`

### Error: "Rate limit exceeded"
- ✅ HuggingFace free tier has fair usage limits
- ✅ Wait a minute and retry
- ✅ For unlimited, upgrade to paid plan

### Response is slow (5-10 seconds)
- ✅ This is normal! HuggingFace uses shared servers
- ✅ For faster responses, use paid tier
- ✅ Or run Ollama locally (same free cost)

### Response is empty or weird
- ✅ Try a simpler query
- ✅ Change model to `mistralai/Mistral-7B-Instruct-v0.1`
- ✅ Check API key is valid

---

## 💡 Tips

1. **First query is slow** - HuggingFace loads model, subsequent queries faster
2. **Free tier limits** - Fair usage policy (~1000 requests/day)
3. **Switch models easily** - Just change `HUGGINGFACE_MODEL` in `.env`
4. **Multiple models** - Try different ones to see which works best

---

## 🎯 Next Steps

After setup works:

1. **Try different queries**:
   - "what is database"
   - "how does tfidf work"
   - "why use mongodb"

2. **Try different models**:
   - `meta-llama/Llama-2-7b-chat-hf` (best quality)
   - `Intel/neural-chat-7b-v3-1` (balanced)

3. **Upgrade if needed**:
   - Free tier: Fair usage
   - Pro plan: Unlimited requests

---

## ✨ You're set!

Your RAG system now uses **HuggingFace's free API**!

No costs, completely free, and works great! 🚀
