--Thanks @bepisfever
local upd = Game.update
local dt_table = {}

--[[To use this:

1. Familarize yourself with dt_table:
- It is a table consisting of other small tables, which go like this {"object_key", "delta_time", "endX", "endY", "animateType", "startX", "startY", "specificCard"}
+ object_key: Used to tell the function what sprite to animate. 
+ delta_time: Basically being the "wait" inbetween every frame.
+ endX: Tell the code to skip to Y when X reaches endX.
+ endY: Tell the code to do its stuff when Y reaches endY, depending on animateType.
+ startX: The reverse of endX. Default is 0.
+ endX: The reverse of endX. Default is 0.
+ specificCard: Only change one card instead of all cards of the same key. If left undeclared, it will resort to object_key instead.
+ animateType:
  - "loop" (default): After running through the entire spritesheet, go back to x = 0, y = 0 and repeat the cycle.
  - "once": After running through the entire spritesheet, go back to x = 0, y = 0.
  - "random": x (0 to endX) and y (0 to endY) is changed randomly.

2. Add the card you want into dt_table, example is left below:
AddRunningAnimation({"j_joker",0.1,1,0}) <-- This probably won't work, see it as a format instead.

3. thats probably it, idk
]]

--[[ 

===================================================================================================================================================
===================== BETTER TUTORIAL COPIED FROM MY MESSAGE TO THE MOD POSTS ON THE DISCORD, COURTESY OF @osquo ==================================
===================================================================================================================================================

Update: I think I've figured out how it works and I'm gonna leave a quick ELI5 for anyone else trying to do the same by explaining how I did it
1) Place `animateObject.lua` (download in this post) in your mod folder.

2) Use `SMODS.load_file('animateObject.lua)()'` in your main mod lua file to load the extra file. make sure you do this above where you define the jokers you want to animate so it gets loaded properly.

3) use the function `AddRunningAnimation()` in your joker definition (`SMODS.joker{}`) to animate it. You will still have to define  `atlas` and `pos` like normal. Make sure `atlas` is an atlas that contains every frame of your animation, left to right, top to bottom.
3.5) the correct setup for `AddRunningAnimation()` is `AddRunningAnimation({'j_(your mod prefix here)_(your joker key here), (time between frames), (number of frames across your atlas is minus one), (ditto but for height instead of across), (type of animation (usually loop)), 0, 0, card})`
3.5.5) Note: the length and height code works by the same logic as `pos = {}` does, which is why the lengths have to be subtracted by one.

4) Overall if done correctly it should be structured like this:
```
--- PREFIX: example_prefix

...

SMODS.load_file('animateObject.lua')()

...

SMODS.Atlas{ --atlas for your animated texture, should contain all frames of your animation
    key = 'animatedjokeratlas',
    path = 'animatedjokeratlas.png',
    px = 71,
    py = 95
}

...

SMODS.Joker{
    key = 'myanimatedjoker',
    ...
    atlas = 'animatedjokeratlas',
    pos = {x = 0, y = 0) --the first frame of the animation. the animation will run to the right until reaching the defined length, then go back to the left and down one, repeat until hitting the end of the defined height.
    AddRunningAnimation({'j_example_prefix_myanimatedjoker',0.125,5,5,'loop',0,0,card}),
```
This doesn't include everything but it should be enough for anyone to make it work, hopefully.
]]--

function GetRunningAnimations()
    return dt_table
end

function SetRunningAnimations(a)
    dt_table = a
end

function AddRunningAnimation(a)
    if type(a) == "table" then
        dt_table[#dt_table+1] = a
    end
end

function Game:update(dt)
    upd(self, dt)
    if dt_table and #dt_table > 0 then
        for index,stuff in pairs(dt_table) do
            if not stuff["currentdt"] then
                stuff["currentdt"] = 0
            end
            stuff["currentdt"] = stuff["currentdt"] + dt
            --print(stuff["currentdt"].." "..stuff[2])
            if G.P_CENTERS and (G.P_CENTERS[stuff[1]] or stuff[8]) and stuff["currentdt"] >= stuff[2] then
                stuff["currentdt"] = 0
                local obj = stuff[8] or G.P_CENTERS[stuff[1]]
                local maxX = stuff[3] or 0
                local maxY = stuff[4] or 0
                local startX = stuff[6] or 0
                local startY = stuff[7] or 0
                local animateType = stuff[5] or "loop"
                if animateType ~= "loop" and animateType ~= "once" and animateType ~= "random" then
                    print("Automatically setting this to loop, are you sure you did it right?: "..animateType)
                    animateType = "loop"
                end
                --card.children.center:set_sprite_pos({x = 0, y = 0})
                if stuff[8] then
                    if not stuff["currentX"] then stuff["currentX"] = startX end
                    if not stuff["currentY"] then stuff["currentY"] = startY end
                    if animateType == "loop" or animateType == "once" then
                        if stuff["currentX"] >= maxX and stuff["currentY"] >= maxY then
                            stuff["currentX"] = startX
                            stuff["currentY"] = startY
                            obj.children.center:set_sprite_pos({x = stuff["currentX"], y = stuff["currentY"]})
                            if animateType == "once" then
                                dt_table[index] = nil
                                goto continue
                            end
                        elseif stuff["currentX"] < maxX then
                            stuff["currentX"] = stuff["currentX"]+ 1
                            obj.children.center:set_sprite_pos({x = stuff["currentX"], y = stuff["currentY"]})
                        elseif stuff["currentY"] < maxY then
                            stuff["currentX"] = startX
                            stuff["currentY"] = stuff["currentY"] + 1
                            obj.children.center:set_sprite_pos({x = stuff["currentX"], y = stuff["currentY"]})
                        end 
                    elseif animateType == "random" then
                        stuff["currentX"] = math.random(startX,maxX)
                        stuff["currentY"] = math.random(startY,maxY)
                        obj.children.center:set_sprite_pos({x = stuff["currentX"], y = stuff["currentY"]})
                    end
                else
                    if animateType == "loop" or animateType == "once" then
                        if obj.pos.x >= maxX and obj.pos.y >= maxY then
                            obj.pos.x = startX
                            obj.pos.y = startY
                            if animateType == "once" then
                                dt_table[index] = nil
                                goto continue
                            end
                        elseif obj.pos.x < maxX then
                            obj.pos.x = obj.pos.x + 1
                        elseif obj.pos.y < maxY then
                            obj.pos.x = startX
                            obj.pos.y = obj.pos.y + 1
                        end 
                    elseif animateType == "random" then
                        obj.pos.x = math.random(startX,maxX)
                        obj.pos.y = math.random(startY,maxY)
                    end
                end
            end
        ::continue::
        end
    end
end