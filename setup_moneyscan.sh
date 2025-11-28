setup_moneyscan.sh
#!/bin/bash

echo "🚀 Moneyscan AI – Full Project Setup Starting..."

# 1) Create folders
mkdir -p backend
mkdir -p frontend
mkdir -p telegram-bot
mkdir -p ai-model
mkdir -p dataset

# 2) Create Backend Files
cat << 'EOF' > backend/server.js
const express = require('express');
const cors = require('cors');
const multer = require('multer');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());

const storage = multer.memoryStorage();
const upload = multer({ storage });

app.post('/api/check-currency', upload.single('image'), async (req, res) => {
    if (!req.file) return res.status(400).json({ error: "No image uploaded" });

    // Fake AI response (real AI added later)
    const fakeResult = {
        currency: "USD",
        real: Math.random() > 0.5
    };

    res.json(fakeResult);
});

app.listen(4000, () => console.log("Backend running on port 4000"));
EOF

# 3) Frontend basic
cat << 'EOF' > frontend/index.html
<html>
  <body>
    <h1>Moneyscan AI</h1>
    <input type="file" id="fileInput" />
    <button onclick="send()">Check</button>

    <script>
      async function send() {
        const file = document.getElementById("fileInput").files[0];
        const formData = new FormData();
        formData.append("image", file);

        const res = await fetch("http://localhost:4000/api/check-currency", {
          method: "POST",
          body: formData
        });

        const data = await res.json();
        alert(JSON.stringify(data));
      }
    </script>
  </body>
</html>
EOF

# 4) Telegram Bot
cat << 'EOF' > telegram-bot/bot.js
const TelegramBot = require('node-telegram-bot-api');
const token = "YOUR_BOT_TOKEN_HERE";

const bot = new TelegramBot(token, { polling: true });

bot.on('photo', (msg) => {
    bot.sendMessage(msg.chat.id, "Image received! AI checking will be added soon.");
});
EOF

echo "✅ DONE! Your project is ready."
