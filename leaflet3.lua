-- Version: 
--Coordinates for origin points
local groups = {
  {{-23.53,-38.88,58,-117.64}, {-4.29,-63.21,58,-112.53}, {12.47,-78.68,58,-113.82}},
  {{-13.73,79.80,58,113.96}, {3.66,62.51,58,113.93}, {22.66,39.36,58,118.05}}
}

local origin_dropoff = {395, -8, 58.64, -3}

-- How many slots with leaflets
local number_of_slots = 3
local number_of_groups = 2

-- Which leaflet needs to be grabbed next from 0 to 2
local next_leaflet = 0

-- Which group of slots are we grabbing from.
local next_group = 0

-- Offset towards the leaflet
local offset_x = -54
-- Pickup offset away from leaflet
local offset_y = -40
-- Pickup offset Z
local offset_z = 60

-- Input Pins
local pin_in_leaflet = 1

-- Output Pins
local pin_out_feedback = 1
local pin_open_gripper = 7
local pin_close_gripper = 8


-- Time takes to turn on and off feedback pin
local delay_pin_toggle = 2500

-- Function that returns the full joint values for the leaflet that needs to be grabbed next
-- Then prepares things for the next iteration
function next_coords()
  if next_leaflet == 0 then
    offset_y = -offset_y
  end

  local joints = groups[next_group+1][next_leaflet+1]
  next_leaflet = (next_leaflet + 1) % number_of_slots
  
  --Here we check if we need to move to the next group of slots for the next iteration
  if next_leaflet == 0 then
    next_group = (next_group + 1) % number_of_groups
  end
  return joints
end

function move_to_next_leaflet()
  local joints = next_coords()
  JointMovJ({joint = joints, sync = true})
end

function pick_up_leaflet()
    DO(pin_open_gripper, ON)
    Sleep(4500)
    RelMovL({offset_x, 0, 0, 0}) -- move to leaflet with open gripper 
    Sync()
    
    DO(pin_open_gripper, OFF) -- put gripper in neutral position
    Sleep(500)
    
    DO(pin_close_gripper, ON)
    Sleep(4000)
    
    RelMovL({0, 0, offset_z, 0}) -- move upwards
    Sync()
    
    RelMovL({100, offset_y, 0, 0}) -- move diagonally
    Sync()
 end

function drop_off_leaflet()
  --SpeedJ(30)
  MovJ({coordinate = origin_dropoff, sync = true}, {SpeedJ=30, AccJ=5})
  Sleep(2000)
  
  RelMovL({0,0,-40,0}) -- move downwards to put leaflet in slot
  Sync()
  
  RelMovL({-75, 0, 0, 0}) -- move backwards x to slide leaflet in slot
  Sync()
  
  DO(pin_close_gripper, OFF)
  DO(pin_open_gripper, ON)
  Sleep(3000)
  
  RelMovL({0,0,180,0}) -- move away upwards from placed leaflet
  Sync()
  
  DO(pin_open_gripper, OFF)
 end
 
--Main program loop 
function main()
  -- turn off initial pins
  DO(pin_out_feedback, OFF)
  DO(pin_open_gripper, OFF)
  DO(pin_close_gripper, OFF)

  while(true)
  do
    input_leaflet = DI(pin_in_leaflet)
    if input_leaflet == OFF then
      print("Received signal")
      
      move_to_next_leaflet()
      pick_up_leaflet()
      drop_off_leaflet()
      
      Sync()
      
      DO(pin_out_feedback, ON)
      print("Sending output")
      Sleep(delay_pin_toggle)
      DO(pin_out_feedback, OFF)
    end
  end
end

main() 