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
            x=352,
            y=548,
            width=36,
            height=40,

        },
        {
            -- arrow
            x=384,
            y=132,
            width=80,
            height=256,

        },
        {
            -- button_back
            x=8,
            y=8,
            width=200,
            height=128,

        },
        {
            -- button_settings
            x=216,
            y=124,
            width=160,
            height=160,

        },
        {
            -- cart
            x=304,
            y=548,
            width=40,
            height=40,

        },
        {
            -- eliminate
            x=404,
            y=8,
            width=100,
            height=116,

        },
        {
            -- fire
            x=8,
            y=440,
            width=140,
            height=168,

        },
        {
            -- flame
            x=156,
            y=456,
            width=140,
            height=168,

        },
        {
            -- lock
            x=8,
            y=144,
            width=160,
            height=160,

        },
        {
            -- panda
            x=472,
            y=132,
            width=32,
            height=36,

        },
        {
            -- pepper
            x=344,
            y=396,
            width=160,
            height=144,

        },
        {
            -- skip
            x=8,
            y=616,
            width=140,
            height=120,

        },
        {
            -- skipLevel
            x=8,
            y=312,
            width=152,
            height=120,

        },
        {
            -- snail
            x=216,
            y=8,
            width=180,
            height=108,

        },
        {
            -- star
            x=176,
            y=292,
            width=160,
            height=156,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
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
