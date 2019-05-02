--[[----------------------------------------------------------------------------

  Application Name:
  SensorData_InspectorP

  Summary:
  Accessing image metadata for each acquired live image.

  How to Run:
  A connected InpspectorP6xx device is necessary to run this sample. Starting this
  sample is possible either by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main or processImage function to debug step-by-step.
  See the acquired images in the image viewer on the DevicePage.

  More Information:
  See the tutorial "Devices - InspectorP - TriggeringAndAcquisition".

------------------------------------------------------------------------------]]

--Start of Global Scope---------------------------------------------------------

-- Create and configure camera
local camera = Image.Provider.Camera.create()

local config = Image.Provider.Camera.V2DConfig.create()
config:setBurstLength(0)    -- Continuous acquisition
config:setFrameRate(10)     -- Hz
config:setShutterTime(700)  -- us

camera:setConfig(config)

-- Create viewer
local viewer = View.create()

--End of Global Scope-----------------------------------------------------------


--Start of Function and Event Scope---------------------------------------------

local function main()
  camera:enable()
  camera:start()
end
Script.register("Engine.OnStarted", main)

local function processImage(im, sensorData)
  viewer:clear()
  viewer:addImage(im)
  viewer:present()
  print(sensorData:toString())
  print("FrameNo = "..sensorData:getFrameNumber())
  print("Timestamp = "..sensorData:getTimestamp().." us")
  print("Origin = "..sensorData:getOrigin())
  print("------------------------------------------------------")
end
camera:register("OnNewImage", processImage)

--End of Function and Event Scope--------------------------------------------------