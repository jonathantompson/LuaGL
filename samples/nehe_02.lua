dofile('loadLuaGL.lua')

function Reshape(width, height)
  gl.Viewport(0, 0, width, height)

  gl.MatrixMode('PROJECTION')   -- Select The Projection Matrix
  gl.LoadIdentity()             -- Reset The Projection Matrix
  
  if height == 0 then           -- Calculate The Aspect Ratio Of The Window
    height = 1
  end

  glu.Perspective(80, width / height, 1, 5000)

  gl.MatrixMode('MODELVIEW')    -- Select The Model View Matrix
  gl.LoadIdentity()             -- Reset The Model View Matrix
end

function DrawGLScene()
  gl.Clear('COLOR_BUFFER_BIT,DEPTH_BUFFER_BIT') -- Clear Screen And Depth Buffer
  
  gl.LoadIdentity()              -- Reset The Current Modelview Matrix
  gl.Translate(-1.5, 0, -6)      -- Move Left 1.5 Units And Into The Screen 6.0
  
  gl.Begin('TRIANGLES')          -- Drawing Using Triangles
    gl.Vertex( 0,  1, 0)         -- Top
    gl.Vertex(-1, -1, 0)         -- Bottom Left
    gl.Vertex( 1, -1, 0)         -- Bottom Right
  gl.End()                       -- Finished Drawing The Triangle
  
  gl.Translate(3, 0, 0)          -- Move Right 3 Units
  
  gl.Begin('QUADS')              -- Draw A Quad
    gl.Vertex(-1,  1, 0)         -- Top Left
    gl.Vertex( 1,  1, 0)         -- Top Right
    gl.Vertex( 1, -1, 0)         -- Bottom Right
    gl.Vertex(-1, -1, 0)         -- Bottom Left
  gl.End()

  glut.SwapBuffers()
end

function Keyboard(key)
  if key == 27 then
    os.exit()
  end
end

function SpecialKeys(key, x, y)
  if key == 1 then               -- Pressed F1 ?
    if fullscreen then
      fullscreen = false
      glut.ReshapeWindow(500, 500)
      glut.PositionWindow(50, 50)
    else
      fullscreen = true
      glut.FullScreen()
    end
  end
end

function Init()
  gl.ShadeModel('SMOOTH')            -- Enable Smooth Shading
  gl.ClearColor(0, 0, 0, 0.5)        -- Black Background
  gl.ClearDepth(1.0)                 -- Depth Buffer Setup
  gl.Enable('DEPTH_TEST')            -- Enables Depth Testing
  gl.DepthFunc('LEQUAL')             -- The Type Of Depth Testing To Do
  gl.Enable('COLOR_MATERIAL')
  gl.Hint('PERSPECTIVE_CORRECTION_HINT','NICEST')
end

glut.Init()
glut.InitDisplayMode()
glut.InitWindowSize(640, 480)
glut.CreateWindow('LuaGL Test Application 02')
glut.DisplayFunc('DrawGLScene')
glut.ReshapeFunc('Reshape')
glut.KeyboardFunc('Keyboard')
glut.SpecialFunc('SpecialKeys')

Init()

glut.MainLoop()
