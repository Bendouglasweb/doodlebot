=begin

Calculate the X/Y Position of the new location	

Input Variables:
	ox:	Origin X, first position in grid map
	oy:	Origin Y, first position in grid map

	vx:	New pos X relative positioning within cell
	vy:	New pos Y relative positioning within cell

	cn:	Cell Number
	gl:	Grid Length

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

puts calcspeed(100.0,1.0)
