require 'pi_piper'
include PiPiper

$pm1_1a = PiPiper::Pin.new(:pin => 5, :direction => :out)
$pm1_1b = PiPiper::Pin.new(:pin => 6, :direction => :out)
$pm1_2a = PiPiper::Pin.new(:pin => 13, :direction => :out)
$pm1_2b = PiPiper::Pin.new(:pin => 19, :direction => :out)

$state = 1

delay = 0.001

def step(w1,w2,w3,w4)

	w1 ? $pm1_1a.on : $pm1_1a.off
	w2 ? $pm1_2a.on : $pm1_2a.off
	w3 ? $pm1_1b.on : $pm1_1b.off
	w4 ? $pm1_2b.on : $pm1_2b.off

end

def release

	$pm1_1a.off
	$pm1_2a.off
	$pm1_1b.off
	$pm1_2b.off
	$state = 1

end

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

def forward(delay,turns)

	turns.times do
		turn 1
		sleep delay
	end
end

def reverse(delay,turns)

	turns.times do

		turn 0
		sleep delay
	
	end

end

# --------- Begin main program ---------------
	


