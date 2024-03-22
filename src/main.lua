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

local pd <const> = playdate;

local inputListener = Listener()
local inputEmitter = EventEmitter()
local controllerEmitter = EventEmitter()

local aInputController = InputController("a", "kButtonA", controllerEmitter)
local bInputController = InputController("b", "kButtonB", controllerEmitter)
local upInputController = InputController("up", "kButtonUp", controllerEmitter)
local downInputController = InputController("down", "kButtonDown", controllerEmitter)
local leftInputController = InputController("left", "kButtonLeft", controllerEmitter)
local rightInputController = InputController("right", "kButtonRight", controllerEmitter)

controllerEmitter:addListener(inputListener)

inputEmitter:addListener(aInputController)
inputEmitter:addListener(bInputController)
inputEmitter:addListener(upInputController)
inputEmitter:addListener(downInputController)
inputEmitter:addListener(leftInputController)
inputEmitter:addListener(rightInputController)

function playdate.update()
   --- Main Game Loop

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