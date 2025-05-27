# Roblox Asset ID Encoder

This is a simple Lua script designed to obfuscate Roblox asset IDs by:
- Hex-encoding the numeric ID
- URL-encoding the hex string
- Adding bait characters before and after the encoded string

---

### Why use this?

While it’s not a bulletproof protection against advanced loggers, this adds a simple layer of obfuscation that:
- Makes the asset ID unreadable at a glance
- Confuses anyone expecting just raw numbers or standard URLs

