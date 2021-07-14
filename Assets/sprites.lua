--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:d64d004446d6799355be2ea85f352709:fcef4404fee8eee5f2072fedb98ee5bc:ce59e0ef6b4af9fefc088af809f682f1$
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
            -- New Piskel (1)
            x=1,
            y=1,
            width=10,
            height=32,

            sourceX = 11,
            sourceY = 0,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- New Piskel-2.png
            x=1,
            y=35,
            width=14,
            height=14,

            sourceX = 8,
            sourceY = 7,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- New Piskel
            x=13,
            y=1,
            width=10,
            height=32,

            sourceX = 11,
            sourceY = 0,
            sourceWidth = 32,
            sourceHeight = 32
        },
    },

    sheetContentWidth = 24,
    sheetContentHeight = 50
}

SheetInfo.frameIndex =
{

    ["Player2"] = 1,
    ["Ball"] = 2,
    ["Player1"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
