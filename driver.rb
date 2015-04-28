require 'pi_piper'
include PiPiper

# Motor one outputs

$pm1_1a = PiPiper::Pin.new(:pin => 5, :direction => :out)  # Coil 1A - Grey Wire
$pm1_1b = PiPiper::Pin.new(:pin => 6, :direction => :out)  # Coil 1B - Green Wire
$pm1_2a = PiPiper::Pin.new(:pin => 13, :direction => :out) # Coil 2A - Yellow Wire
$pm1_2b = PiPiper::Pin.new(:pin => 19, :direction => :out) # Coil 2B - Red Wire

# Motor two outputs

$pm2_1a = PiPiper::Pin.new(:pin => 12, :direction => :out)  # Coil 1A - Grey Wire
$pm2_1b = PiPiper::Pin.new(:pin => 16, :direction => :out)  # Coil 1B - Green Wire
$pm2_2a = PiPiper::Pin.new(:pin => 20, :direction => :out) # Coil 2A - Yellow Wire
$pm2_2b = PiPiper::Pin.new(:pin => 21, :direction => :out) # Coil 2B - Red Wire

#Global coil state (val: 1-4)
$Lstate = 1		# Left motor = motor 0
$Rstate = 1		# Right motor = motor 1



#Method to energize specific coils
#m: 
#	0 -> left motor
#	1 -> right motor
def step(m,w1,w2,w3,w4)
	if m == 0	
		w1 ? $pm1_1a.on : $pm1_1a.off
		w2 ? $pm1_2a.on : $pm1_2a.off
		w3 ? $pm1_1b.on : $pm1_1b.off
		w4 ? $pm1_2b.on : $pm1_2b.off
	else
		w1 ? $pm2_1a.on : $pm2_1a.off
		w2 ? $pm2_2a.on : $pm2_2a.off
		w3 ? $pm2_1b.on : $pm2_1b.off
		w4 ? $pm2_2b.on : $pm2_2b.off
	end

end

#De-energize all coils
def release
	$pm1_1a.off
	$pm1_2a.off
	$pm1_1b.off
	$pm1_2b.off
	
	$pm2_1a.off
	$pm2_2a.off
	$pm2_1b.off
	$pm2_2b.off
#	$state = 1
end

# Method to move motor to the next set of coils, progressing from
# whatever coil/state we are in currently. Passes in either a 0 or 1
# 0 = Reverse Turn
# 1 = Forward Turn
#m: 
#	0 -> left motor
#	1 -> right motor
def turn(m,dir)

	if m == 0

		# Change state due to direction
		if dir == 1
			$Lstate = $Lstate + 1
		else
			$Lstate = $Lstate - 1
		end

		#Check if we need to rollover
		if $Lstate == 5
			$Lstate = 1
		elsif $Lstate == 0
			$Lstate = 4
		end


		#Do Step
		if $Lstate == 1
			step(0,true,true,false,false)
		elsif $Lstate == 2
			step(0,false,true,true,false)
		elsif $Lstate == 3
			step(0,false,false,true,true)
		elsif $Lstate == 4
			step(0,true,false,false,true)
		end
		
	else
	
			# Change state due to direction
		if dir == 1
			$Rstate = $Rstate + 1
		else
			$Rstate = $Rstate - 1
		end

		#Check if we need to rollover
		if $Rstate == 5
			$Rstate = 1
		elsif $Rstate == 0
			$Rstate = 4
		end


		#Do Step
		if $Rstate == 1
			step(1,true,true,false,false)
		elsif $Rstate == 2
			step(1,false,true,true,false)
		elsif $Rstate == 3
			step(1,false,false,true,true)
		elsif $Rstate == 4
			step(1,true,false,false,true)
		end
	
	
	end

end

# Step forward a specified number of times with delay
#m: 
#	0 -> left motor
#	1 -> right motor
def driveMotor(m,delay,turns)

	if m == 0
		if delay > 0
			turns.times do 
				turn 0 1	# turn the left motor forward		( extend belt )
				sleep delay
			end
		else
			turns.times do 
				turn 0 0	# turn the left motor backwards		( retract belt )
				sleep delay
			end
		end	
		
	else
		if delay > 0
			turns.times do 
				turn 1 0	# turn the right motor backwards	( extend belt )
				sleep delay
			end
		else
			turns.times do 
				turn 1 1	# turn the right motor forwards		( retract belt )
				sleep delay
			end
		end	
	end



end

# Same as forward but reverse


# --------- Begin ---------------

