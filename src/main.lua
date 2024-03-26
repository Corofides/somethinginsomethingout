---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jameslendrem.
--- DateTime: 09/11/2023 10:56
---

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "event"
import "listener"
import "eventEmitter"
import "inputController"
import "button"
import "view"

local pd <const> = playdate
local gfx <const> = pd.graphics

local inputListener = Listener()
local inputEmitter = EventEmitter()
local controllerEmitter = EventEmitter()

local aInputController = InputController("a", "kButtonA", controllerEmitter)
local bInputController = InputController("b", "kButtonB", controllerEmitter)
local upInputController = InputController("up", "kButtonUp", controllerEmitter)
local downInputController = InputController("down", "kButtonDown", controllerEmitter)
local leftInputController = InputController("left", "kButtonLeft", controllerEmitter)
local rightInputController = InputController("right", "kButtonRight", controllerEmitter)

function is_array(table)

   local is_array = true;

   for key, value in pairs(table) do
      if type(key) == "string" then
         is_array = false
         break
      end
   end

   return is_array

end


print(test)

local innerView = View("Test", {
   left = 200,
   top = 140,
   borderTopWidth = 2,
   borderBottomWidth = 2,
   borderLeftWidth = 2,
   borderRightWidth = 2,
   paddingLeft = 10,
   paddingRight = 10,
   paddingTop = 10,
   paddingBottom = 10,
   marginTop = -5,
   marginLeft = -5,
})

local view = View(innerView, {
   left = 200,
   top = 140,
   borderTopWidth = 2,
   borderBottomWidth = 2,
   borderLeftWidth = 2,
   borderRightWidth = 2,
   paddingLeft = 10,
   paddingRight = 10,
   paddingTop = 10,
   paddingBottom = 10,
})

local view = View(
        {
           View("Item 1", {
              borderTopWidth = 2,
              borderBottomWidth = 2,
              borderLeftWidth = 2,
              borderRightWidth = 2,
              paddingLeft = 10,
              paddingRight = 10,
              paddingTop = 10,
              paddingBottom = 10
           }),
           View("Item 2", {
            borderTopWidth = 2,
            borderBottomWidth = 2,
            borderLeftWidth = 2,
            borderRightWidth = 2,
            paddingLeft = 10,
            paddingRight = 10,
            paddingTop = 10,
            paddingBottom = 10
            }),
           View("Item 3", {
              borderTopWidth = 2,
              borderBottomWidth = 2,
              borderLeftWidth = 2,
              borderRightWidth = 2,
              paddingLeft = 10,
              paddingRight = 10,
              paddingTop = 10,
              paddingBottom = 10
           })
        }, {
   left = 200,
   top = 140,
   borderTopWidth = 2,
   borderBottomWidth = 2,
   borderLeftWidth = 2,
   borderRightWidth = 2,
   paddingLeft = 10,
   paddingRight = 10,
   paddingTop = 10,
   paddingBottom = 10,
})
view:drawView()

controllerEmitter:addListener(inputListener)

local buttonListener = Listener();

local buttonEmitter = EventEmitter();

--[[ local button = Button(100, 90, 100, 50, "Start Game", controllerEmitter)
 local button1 = Button(300, 90, 100, 50, "Start Game", controllerEmitter)
local button2 = Button(100, 190, 100, 50, "Start Game", controllerEmitter)
local button3 = Button(300, 190, 100, 50, "Start Game", controllerEmitter)

button1:triggerFocus(true);

button2:triggerFocus(true);
button2:triggerActive(true);

buttonListener.onEvent = function(listener, event)
   if (event.name == "downClick") then
      button:triggerFocus(true)
   end

   if (event.name == "upClick") then
      button:triggerFocus(false)
   end

   if (event.name == "aPress") then
      button:triggerActive(true)
   end

   if (event.name == "aRelease") then
      button:triggerActive(false);
   end

end

controllerEmitter:addListener(buttonListener)

--]]

inputEmitter:addListener(aInputController)
inputEmitter:addListener(bInputController)
inputEmitter:addListener(upInputController)
inputEmitter:addListener(downInputController)
inputEmitter:addListener(leftInputController)
inputEmitter:addListener(rightInputController)



function playdate.update()
   --- Main Game Loop

   gfx.sprite.update()

   if (pd.buttonIsPressed(pd.kButtonDown)) then
      inputEmitter:emitEvent("kButtonDownIn")
   else
      inputEmitter:emitEvent("kButtonDownOut")
   end

   if (pd.buttonIsPressed(pd.kButtonUp)) then
      inputEmitter:emitEvent("kButtonUpIn")
   else
      inputEmitter:emitEvent("kButtonUpOut")
   end

   if (pd.buttonIsPressed(pd.kButtonLeft)) then
      inputEmitter:emitEvent("kButtonLeftIn")
   else
      inputEmitter:emitEvent("kButtonLeftOut")
   end

   if (pd.buttonIsPressed(pd.kButtonRight)) then
      inputEmitter:emitEvent("kButtonRightIn")
   else
      inputEmitter:emitEvent("kButtonRightOut")
   end

   if (pd.buttonIsPressed(pd.kButtonA)) then
      inputEmitter:emitEvent("kButtonAIn")
   else
      inputEmitter:emitEvent("kButtonAOut")
   end

   if (pd.buttonIsPressed(pd.kButtonB)) then
      inputEmitter:emitEvent("kButtonBIn")
   else
      inputEmitter:emitEvent("kButtonBOut")
   end

end