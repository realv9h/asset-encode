-- This is an easy to understand explanation of how antilogs generally hide the raw asset IDs.
-- While not a huge deterent against loggers, it provides some kind of
-- protection from people with only basic knowledge.

-- 'robloxID' will be what your asset's ID is.
local robloxID = ''

-- Function to encode the ID into a hexadecimal string.
-- 1818 > 0x...
local function toHex(id)
    return string.format("0X%X", id)
end

-- Function to URL encode the ID.
-- 1818 --> %31%38%31%38
local function urlEncode(str)
    local encoded = ""
    for i = 1, #str do
        encoded = encoded .. string.format("%%%02X", string.byte(str:sub(i, i)))
    end
    return encoded
end

-- Bait characters are URL-encoded whitespace or control characters such as newline (%0A),
-- vertical tab (%0B), form feed (%0C), and carriage return (%0D).
-- Including these harmless sequences before and after the encoded payload adds noise,
-- which generally confuses people as anything other than %0A is not
-- typically used.
local baitChars = { "0A", "%0B", "%0C", "%0D" }

-- We now generate a random sequence of bait characters of the specified length.
local function generateBait(length)
    local bait = ""
    for i = 1, length do
        bait = bait .. baitChars[math.random(#baitChars)]
    end
    return bait
end

-- We convert it to hex first, as vice-versa does not work when you call the API.
local hexID = toHex(robloxID)

-- Now we convert it to URL, making it become from something as
-- '0x...' into '%30%78...'. As url encoded assets typically only contains
-- '%3x' sequences in them and are easy to see.
local urlEncodedHexID = urlEncode(hexID)

-- We create randomized bait sequences to surround the encoded asset ID.
-- This helps disguise the encoded data by padding it with benign control characters.
local baitPrefix = generateBait(math.random(3, 5))
local baitSuffix = generateBait(math.random(3, 5))

-- This final string is usable directly while also being unreadable to people expecting a number.
local finalEncodedString = baitPrefix .. urlEncodedHexID .. baitSuffix

print(finalEncodedString)
