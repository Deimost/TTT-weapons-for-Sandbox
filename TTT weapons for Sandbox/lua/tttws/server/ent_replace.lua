---- Replace old and boring ents with new and shiny SENTs

ents.TTT = {}

local table = table
local math = math
local pairs = pairs

local function ReplaceSingle(ent, newname)

   -- Ammo that has been mapper-placed will not have a pos yet at this point for
   -- reasons that have to do with being really annoying. So don't touch those
   -- so we can replace them later. Grumble grumble.
   if ent:GetPos() == vector_origin then
      return
   end

   ent:SetSolid(SOLID_NONE)

   local rent = ents.Create(newname)
   rent:SetPos(ent:GetPos())
   rent:SetAngles(ent:GetAngles())
   rent:Spawn()

   rent:Activate()
   rent:PhysWake()

   ent:Remove()
end

-- Remove ZM ragdolls that don't work, AND old player ragdolls.
-- Exposed because it's also done at BeginRound
function ents.TTT.RemoveRagdolls(player_only)
   for k, ent in ipairs(ents.FindByClass("prop_ragdoll")) do
      if IsValid(ent) then
         if not player_only and string.find(ent:GetModel(), "zm_", 6, true) then
            ent:Remove()
         elseif ent.player_ragdoll then
            -- cleanup ought to catch these but you know
            ent:Remove()
         end
      end
   end
end

local cls = "" -- avoid allocating
local sub = string.sub
local function ReplaceOnCreated(s, ent)
   -- Invalid ents are of no use anyway
   if not ent:IsValid() then return end

   cls = ent:GetClass()

   if sub(cls, 1, 4) == "item" then
      ReplaceAmmoSingle(ent, cls)
   elseif sub(cls, 1, 6) == "weapon" then
      ReplaceWeaponSingle(ent, cls)
   end
end

local noop = util.noop

GM.OnEntityCreated = ReplaceOnCreated

-- Helper so we can easily turn off replacement stuff when we don't need it
function ents.TTT.SetReplaceChecking(state)
   if state then
      GAMEMODE.OnEntityCreated = ReplaceOnCreated
   else
      GAMEMODE.OnEntityCreated = noop
   end
end

-- GMod's game.CleanUpMap destroys rope entities that are parented. This is an
-- experimental fix where the rope is unparented, the map cleaned, and then the
-- rope reparented.
-- Same happens for func_brush.
local broken_parenting_ents = {
   "move_rope",
   "keyframe_rope",
   "info_target",
   "func_brush"
}

function ents.TTT.FixParentedPreCleanup()
   for _, rcls in pairs(broken_parenting_ents) do
      for k,v in ipairs(ents.FindByClass(rcls)) do
         if v.GetParent and IsValid(v:GetParent()) then
            v.CachedParentName = v:GetParent():GetName()
            v:SetParent(nil)

            if not v.OrigPos then
               v.OrigPos = v:GetPos()
            end
         end
      end
   end
end

function ents.TTT.FixParentedPostCleanup()
   for _, rcls in pairs(broken_parenting_ents) do
      for k,v in ipairs(ents.FindByClass(rcls)) do
         if v.CachedParentName then
            if v.OrigPos then
               v:SetPos(v.OrigPos)
            end

            local parents = ents.FindByName(v.CachedParentName)
            if #parents == 1 then
               local parent = parents[1]
               v:SetParent(parent)
            end
         end
      end
   end
end

function ents.TTT.TriggerRoundStateOutputs(r, param)
   r = r or GetRoundState()

   for _, ent in ipairs(ents.FindByClass("ttt_map_settings")) do
      if IsValid(ent) then
         ent:RoundStateTrigger(r, param)
      end
   end
end