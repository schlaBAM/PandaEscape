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
            x=88,
            y=137,
            width=9,
            height=10,

        },
        {
            -- arrow
            x=96,
            y=33,
            width=20,
            height=64,

        },
        {
            -- button_back
            x=2,
            y=2,
            width=50,
            height=32,

        },
        {
            -- button_settings
            x=54,
            y=31,
            width=40,
            height=40,

        },
        {
            -- cart
            x=76,
            y=137,
            width=10,
            height=10,

        },
        {
            -- eliminate
            x=101,
            y=2,
            width=25,
            height=29,

        },
        {
            -- fire
            x=2,
            y=110,
            width=35,
            height=42,

        },
        {
            -- flame
            x=39,
            y=114,
            width=35,
            height=42,

        },
        {
            -- lock
            x=2,
            y=36,
            width=40,
            height=40,

        },
        {
            -- panda
            x=118,
            y=33,
            width=8,
            height=9,

        },
        {
            -- pepper
            x=86,
            y=99,
            width=40,
            height=36,

        },
        {
            -- skip
            x=2,
            y=154,
            width=35,
            height=30,

        },
        {
            -- skipLevel
            x=2,
            y=78,
            width=38,
            height=30,

        },
        {
            -- snail
            x=54,
            y=2,
            width=45,
            height=27,

        },
        {
            -- star
            x=44,
            y=73,
            width=40,
            height=39,

        },
    },
    
    sheetContentWidth = 128,
    sheetContentHeight = 256
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
