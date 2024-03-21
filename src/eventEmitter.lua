---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jameslendrem.
--- DateTime: 21/03/2024 21:03
---

class("EventEmitter").extends()

function EventEmitter:init()
    self.listeners = {}
end

function EventEmitter:emitEvent(eventName)
    local event <const> = Event(eventName)

    for i, listener in pairs(self.listeners) do
        listener:onEvent(event)
    end
end

function EventEmitter:addListener(listener)
    table.insert(self.listeners, listener)
end