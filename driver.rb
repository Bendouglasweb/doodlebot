require 'pi_piper'
include PiPiper

# Motor one outputs

$pm1_1a = PiPiper::Pin.new(:pin => 5, :direction => :out)  # Coil 1A - Grey Wire
$pm1_1b = PiPiper::Pin.new(:pin => 6, :direction => :out)  # Coil 1B - Green Wire
$pm1_2a = PiPiper::Pin.new(:pin => 13, :direction => :out) # Coil 2A - Yellow Wire
$pm1_2b = PiPiper::Pin.new(:pin => 19, :direction => :out) # Coil 2B - Red Wire

#Global coil state (val: 1-4)
$state = 1

#Method to energize specific coils
def step(w1,w2,w3,w4)

	w1 ? $pm1_1a.on : $pm1_1a.off
	w2 ? $pm1_2a.on : $pm1_2a.off
	w3 ? $pm1_1b.on : $pm1_1b.off
	w4 ? $pm1_2b.on : $pm1_2b.off

end

#De-energize all coils
def release
	$pm1_1a.off
	$pm1_2a.off
	$pm1_1b.off
	$pm1_2b.off
#	$state = 1
end

# Method to move motor to the next set of coils, progressing from
# whatever coil/state we are in currently. Passes in either a 0 or 1
# 0 = Reverse Turn
# 1 = Forward Turn
def turn(dir)

	# Change state due to direction
	if dir == 1
		$state = $state + 1
	else
		$state = $state - 1
	end

	#Check if we need to rollover
	if $state == 5
		$state = 1
	elsif $state == 0
		$state = 4
	end


	#Do Step
	if $state == 1
		step(true,true,false,false)
	elsif $state == 2
		step(false,true,true,false)
	elsif $state == 3
		step(false,false,true,true)
	elsif $state == 4
		step(true,false,false,true)
	end

end

# Step forward a specified number of times with delay
def forward(delay,turns)
	turns.times do
		turn 1
		sleep delay
	end
end

# Same as forward but reverse
def reverse(delay,turns)
	turns.times do

		turn 0
		sleep delay
	end
end

# --------- Begin ---------------

