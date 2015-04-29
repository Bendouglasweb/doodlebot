
=begin

    Calculate values for a motor move
        -> For one point-point move
        -> Generic for both motors

    Input Variables
        -> Everything for calcnewpos and calcsteps
        -> positionArray
        -     -> Contains relative position info for move within cell

Returns

    Array of values

        0 -> New R for motor
        1 -> Speed (delay) for turn
        2 -> Number of steps needed to turn

=end
def motorMove(ox,oy,positionArray,gl,curR,beltStepLength,mx,my,stepSecond, cellNum)
    newPos = calcnewpos(ox, oy, positionArray[0], positionArray[1], cellNum, gl)
    newStep = calcsteps(curR, beltStepLength, mx, my, newPos[0], newPos[1])
    curSpeed = calcspeed(newStep[1], stepSecond)
    
    vals = []
    vals[0] = newStep[0]
    vals[1] = curSpeed
    vals[2] = newStep[1]
    return vals
end

=begin
 Main

for each letter

        for each elem in draw letter

                1) Calculates left values (call to motorMove)
                2) calculates right values (call to motorMove)
                3) start left motor thread
                    a) passes in values to driver function
                4) start right motor thread
                    b) passes in values to driver function

        done drawing

        increment cell

done with sentence

=end
def doodlebot
    # constants
    ox = 20
    oy = 20
    
    mxLeft = 0
    mxRight = 100
    myLeft = 100
    myRight = 100
    
    leftMotor = 0
    rightMotor = 1
    
    beltStepLength = 0.1
    stepSecond = 1
    gl = 10
    
    # dynamic variables
    curCell = 0
    
    leftR = 82.46211251
    rightR = 113.137085
    
    $A.each do |coord|
  
        leftVals = motorMove(ox, oy, coord, gl, leftR, beltStepLength, mxLeft, myLeft, stepSecond, curCell)
        rightVals = motorMove(ox, oy, coord, gl, rightR, beltStepLength, mxRight, myRight, stepSecond, curCell)
        
        leftR = leftVals[0]
        rightR = rightVals[0]
        
        puts "Left: #{leftVals[0]} || #{leftVals[1]} || #{leftVals[2]}"
        puts "Right: #{rightVals[0]} || #{rightVals[1]} || #{rightVals[2]}"
        
        #leftMotorThread=Thread.new{driveMotor(leftMotor, leftVals[1], leftVals[2])}
        #rightMotorThread=Thread.new{driveMotor(rightMotor, rightVals[1], leftVals[2])}
        
        #leftMotorThread.join
        #rightMotorThread.join
        
    end
    
end

doodlebot()
