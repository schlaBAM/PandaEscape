--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:50b5ffb93d48f399cd9561ab54139941:a5817ebcf17832c866748c5338513134:ce435692fc93689f71d24df10a8922dc$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- answer
            x=176,
            y=274,
            width=18,
            height=20,

        },
        {
            -- arrow
            x=192,
            y=66,
            width=40,
            height=128,

        },
        {
            -- button_back
            x=4,
            y=4,
            width=100,
            height=64,

        },
        {
            -- button_settings
            x=108,
            y=62,
            width=80,
            height=80,

        },
        {
            -- cart
            x=152,
            y=274,
            width=20,
            height=20,

        },
        {
            -- eliminate
            x=202,
            y=4,
            width=50,
            height=58,

        },
        {
            -- fire
            x=4,
            y=220,
            width=70,
            height=84,

        },
        {
            -- flame
            x=78,
            y=228,
            width=70,
            height=84,

        },
        {
            -- lock
            x=4,
            y=72,
            width=80,
            height=80,

        },
        {
            -- panda
            x=236,
            y=66,
            width=16,
            height=18,

        },
        {
            -- pepper
            x=172,
            y=198,
            width=80,
            height=72,

        },
        {
            -- skip
            x=4,
            y=308,
            width=70,
            height=60,

        },
        {
            -- skipLevel
            x=4,
            y=156,
            width=76,
            height=60,

        },
        {
            -- snail
            x=108,
            y=4,
            width=90,
            height=54,

        },
        {
            -- star
            x=88,
            y=146,
            width=80,
            height=78,

        },
    },
    
    sheetContentWidth = 256,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["answer"] = 1,
    ["arrow"] = 2,
    ["button_back"] = 3,
    ["button_settings"] = 4,
    ["cart"] = 5,
    ["eliminate"] = 6,
    ["fire"] = 7,
    ["flame"] = 8,
    ["lock"] = 9,
    ["panda"] = 10,
    ["pepper"] = 11,
    ["skip"] = 12,
    ["skipLevel"] = 13,
    ["snail"] = 14,
    ["star"] = 15,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
