require './driver.rb'




$benCoord =
		[
				[0.05,0.05],
				[0.95,0.05],
				[0.95,0.95],
				[0.05,0.95],
				[0.05,0.05]

		]

# A
$aCoord =
		[
				[0.05,0.05],
				[0.225,0.4],
				[0.5,0.95],
				[0.775,0.4],
				[0.95,0.5],
				[0.775,0.4],
				[0.225,0.4],
				[0.05,0.05],
				[0.5,0.05],
				[0.95, 0.05]
		]

# B
$bCoord =
		[
				[0.35,0.05],
				[0.35,0.5],
				[0.35,0.95],
				[0.6,0.9],
				[0.7,0.75],
				[0.65,0.6],
				[0.55,0.55],
				[0.75,0.45],
				[0.8,0.3],
				[0.1,0.7],
				[0.5,0.05],
				[0.35,0.05],
				[0.95,0.05]
		]

# C
$cCoord =
		[
				[0.7,0.05],
				[0.45,0.15],
				[0.25,0.35],
				[0.2,0.5],
				[0.25,0.65],
				[0.45,0.85],
				[0.7,0.95],
				[0.45,0.85],
				[0.25,0.65],
				[0.2,0.5],
				[0.25,0.35],
				[0.45,0.15],
				[0.7,0.05],
				[0.95,0.05]
		]

# D
$dCoord =
		[
				[0.25,0.05],
				[0.25,0.5],
				[0.25,0.95],
				[0.65,0.8],
				[0.75,0.5],
				[0.6,0.2],
				[0.25,0.05],
				[0.95,0.05]
		]

# E
$eCoord =
		[
				[0.25,0.05],
				[0.25,0.5],
				[0.25,0.95],
				[0.75,0.95],
				[0.25,0.95],
				[0.25,0.5],
				[0.75,0.5],
				[0.25,0.5],
				[0.25,0.05],
				[0.75,0.05],
				[0.95,0.05]
		]

=begin

Calculate the X/Y Position of the new location	

Input Variables:
	ox:	Origin X, first position in grid map, starts in lower left hand corner
	oy:	Origin Y, first position in grid map, starts in lower left hand corner

	vx:	New pos X relative positioning within cell
	vy:	New pos Y relative positioning within cell

	cn:	Cell Number [unitless] (one horizontal row of 100 cells)
	gl:	Grid Length [centimeters] (10 per letter)

Returns
	Array
		0: New X Position
		1: New Y Position
=end
def calcnewpos(ox,oy,vx,vy,cn,gl)
	vals = []

	vals[0] = ox + cn*gl + vx*gl	#X
	vals[1] = oy + cn*gl + vy*gl	#Y

	return vals
end

def calcnewrelpos(vx, vy, gl)
	vals = []

	vals[0] = vx*gl #xRel
	vals[1] = vy*gl #yRel

	return vals
end

#---------------------------------------------------------------------------
=begin

Calculate Steps Needed

Input Variables:
	cr:	Current R - Extension length of belt for particular motor
	
	bsl:	Belt Step Length - Calibration variable. How far the belt moves per step

	mx:	Motor X Position
	my:	Motor Y Position

	dx:	New X position (result from calcnewpos)
	dy:	New Y position (result from calcnewpos)

Returns
	Array
		0: New Belt Extension
		1: Number of steps needed to turn

=end
def calcsteps(cr,bsl,mx,my,dx,dy)

	newr =  Math.sqrt( ( mx - dx ) ** 2 + (my - dy) ** 2 )
	
	deltar = cr - newr

	steps = deltar / bsl

	vals = []
	
	vals[0] = newr
	vals[1] = steps

	return vals

end


#---------------------------------------------------------------------------
=begin

Calc motor speed

Input Variables

	bs:	Belt steps needed (Result from calcsteps)
	ss:	Step second - global speed factor. How long should a single move take

Returns

	Motor step delay

=end
def calcspeed(bs,ss)
	speed = bs.to_f / ss.to_f 

	val = 1 / speed

	return val

end
