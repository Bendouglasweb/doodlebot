require './driver.rb'
require 'io/console'



#Left
def left
	thr1 = Thread.new { 
		50.times do
			turn(0,1)
			sleep 0.002
		end
	
	}

	thr2 = Thread.new {
		50.times do
			turn(1,1)
			sleep 0.002
		end
	}


	thr1.join
	thr2.join
end






#Up
def up
	thr1 = Thread.new { 
		50.times do
			turn(0,1)
			sleep 0.002
		end

	}

	thr2 = Thread.new {
		50.times do
			turn(1,0)
			sleep 0.002
		end
	}


	thr1.join
	thr2.join
end


#Right
def right
	thr1 = Thread.new { 
		50.times do
			turn(0,0)
			sleep 0.002
		end

	}

	thr2 = Thread.new {
		50.times do
			turn(1,0)
			sleep 0.002
		end
	}


	thr1.join
	thr2.join
end

#Down
def down
	thr1 = Thread.new { 
		50.times do
			turn(0,0)
			sleep 0.002
		end

	}

	thr2 = Thread.new {
		50.times do
			turn(1,1)
			sleep 0.002
		end
	}


	thr1.join
	thr2.join
end


def diag(x)
	case x
	when 1	# quadrant 1
		50.times do
			turn(1,0)
			sleep 0.002
		end
	when 2
		50.times do
			turn(0,1)
			sleep 0.002
		end
	when 3
		50.times do
			turn(1,1)
			sleep 0.002
		end
	when 4
		50.times do
			turn(0,0)
			sleep 0.002
		end	
	end
end


$n = 0

def diagN(x)
	puts $n
	case x
	when 1	# quadrant 1
		($n + 50).times do
			turn(1,0)
			sleep 0.002
		end
	when 2
		($n + 50).times do
			turn(0,1)
			sleep 0.002
		end
	when 3
		($n + 50).times do
			turn(1,1)
			sleep 0.002
		end
	when 4
		($n + 50).times do
			turn(0,0)
			sleep 0.002
		end	
	end
	$n = $n + 15
end




def box
	left
	up
	right
	down
end

def leftGrid

	box
	left
	box
	left
	box
	left
	box
	left
	
	
end


def drawLet(x)
	case x
	when 1		# a
		up
		up
		up
		diag 1
		right
		diag 4
		down
		left
		left
		right
		right
		down
		down
	when 2		# b
		#up
		up
		up
		up
		right
		right
		diag 4
		down
		left
		right
		down
		diag 3
		left
		left
		right	
		right
		right
		
	when 3		# c
		right
		diag 2
		up
		up
		up
		diag 3
		right
		diag 4
		diag 2
		left
		diag 3
		down
		down
		diag 4
		right
		right
		

	when 4		# d
		up
		up
		right
		down
		down
		left
		right
	when 5		# e
		up
		up
		right
		left
		down
		right
		left
		down
		right
	when 6		# f
		up
		up
		right
		left
		down
		right
		left
		down
		right
	when 7		# g
		up
		up
		right
		left
		down
		down
		right
		up
		left
		right
		down
		right
	when 8		# h
		up
		up
		down
		right
		up
		down
		down
		right
	when 9		# i
		up
		up
		down
		down
	end
			
	right

end






def diagBox
	diag 1
	diag 4
	diag 3
	diag 2
end

def diagBoxN
	diagN 1
	diagN 4
	diagN 3
	diagN 2
end

def userInput
	totalInput = ""
	char = ''
	while char != '0' do
		char = STDIN.getch
#		char = char.chr
		totalInput = totalInput + char
		if char == 'w'
			up
		elsif char == 'd'
			right
		elsif char == 's'
			down
		elsif char == 'a'
			left
		elsif char == 'e'
			diag 1
		elsif char == 'q'
			diag 2
		elsif char == 'z'
			diag 3
		elsif char == 'c'
			diag 4
		end
	end

end


if ARGV[0] == 'user'
	userInput
elsif ARGV[0] == 'text'
	inLets = ARGV[1]
        # || "
	lets = inLets.split("")
	inLets.each_byte do |x|
		y = x - 96
		drawLet y


	end

else
#qqq
# do something else

op = 1


if op == 1

	5.times do
		15.times do
			diagBox
			diag 4

		end
		15.times do
			diag 2
		end
		diag 1
	end
elsif op == 2

	40.times do
		diagBoxN
	end

end

end
