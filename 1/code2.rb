
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    last = 0
    arr=[0,0,0]
    valid = false
    idx = 0
    embiggens = 0
    File.open(ARGV[0]).each do |line|
        now = line.to_i
        arr[idx] = now
        idx = idx+1
        valid = true if (idx == 3)
        idx %= 3
        if (valid)
            sum = arr[0]+arr[1]+arr[2]
            if ((last != 0) && (sum > last))
                embiggens = embiggens + 1
            end
            last = sum
        end
    end
    puts embiggens
end
