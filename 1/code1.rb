
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    last = 0
    embiggens=0
    File.open(ARGV[0]).each do |line|
        now = line.to_i
        if ((last != 0) && (now > last))
            embiggens = embiggens+1
        end
        last = now
    end
    puts embiggens
end
