-- basic
SWEP.PrintName = "QuickHealth"			
SWEP.Author = "TheAndrew61"
SWEP.Instructions = "Give yourself some health when you need it!"
SWEP.Category = "TheAndrew61's SWEPs"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.DrawWeaponInfoBox = true

if CLIENT then
  SWEP.DrawAmmo = false
  SWEP.DrawCrosshair = true
  SWEP.Slot = 5
  SWEP.SlotPos = 3
  SWEP.WepSelectIcon = Material("vgui/entities/weapon_quickhealth.png")
end

-- primary click
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

-- secondary click
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

-- attributes
SWEP.HoldType	= "pistol"
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowWorldModel = true
SWEP.FiresUnderwater = true
SWEP.BounceWeaponIcon	 = false
SWEP.ShakeWeaponSelectIcon = false
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

-- audible
SWEP.Primary.Sound = Sound("gain.wav")

-- wep selection icon
function SWEP:DrawWeaponSelection( x, y, w, h, a )
  surface.SetDrawColor ( 255, 255, 255, 255, a )
  surface.SetMaterial( self.WepSelectIcon )
  local size = math.min( w, h )
  surface.DrawTexturedRect( x + w / 2 - size / 2, y, size, size )
end

-- left key
function SWEP:PrimaryAttack()
  if player.GetByID(1):Health() < player.GetByID(1):GetMaxHealth() then
    self.Weapon:EmitSound( Sound(self.Primary.Sound) )
    player.GetByID(1):SetHealth( player.GetByID(1):Health()+10 )
    print("QuickHealth - Gained 10 health")
  end
end

-- right click
function SWEP:SecondaryAttack()
-- nothing!
end

-- reload key
function SWEP:Reload()
  if player.GetByID(1):Health() ~= player.GetByID(1):GetMaxHealth() then
    self.Weapon:EmitSound( Sound("refresh.wav") )
    player.GetByID(1):SetHealth( player.GetByID(1):GetMaxHealth() )
    print("QuickHealth - Restored default health")
  end
end

-- SPECIAL - play sound when player hits the ground, if the SWEP is being held
wepOut = false
-- weapon is pulled out
function SWEP:Deploy()
  wepOut = true
  return true
end
 -- weapon is switched
 function SWEP:Holster()
   wepOut = false
   return true
 end
-- falling damage function
function FlPlayerFallDamage( pPlayer, m_flFallVelocity )
  if wepOut == true then
    player.GetByID(1):EmitSound(Sound("lose.wav"))
  end
end
-- binding the function to the event
hook.Add("GetFallDamage", "FlPlayerFallDamage", FlPlayerFallDamage)


-- EXTRA - get player's coordinates
concommand.Add("coords", function( ply )
    print( ply:GetPos() )
end)