class Convlf
	puts ("CONVERSION OF CRLF-LF START")
	i=0
	loop do
		if (ARGV[i]==nil)||(i>10)
			break i
		end
		print ARGV[i],"\t"

		begin
			fin=File.new(ARGV[i],"r")
			fot=File.new(ARGV[i]+".ux","w")
			cr_flag=false
			fin.each_byte do |ch|
				if(cr_flag&&ch!=10)
					fot.putc(13)
				end
				if(!(cr_flag=(ch==13)))
					fot.putc(ch)
				end
			end
			fot.close
			fin.close
		rescue
			print "\n","THIS FILE CAN NOT BE FOUND: ",ARGV[i],"\n"
		end

		i+=1
	end
	puts "CONVERSION OF LCRL-FF END"
end

print "\n"

class Convexec
	puts ("CONVERSION OF EXEC START")
	puts ("CONVERSION OF EXEC END")
end
