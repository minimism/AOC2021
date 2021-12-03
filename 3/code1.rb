
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    lines = 0
    lineLength = 0
    results = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    File.open(ARGV[0]).each_with_index do |line, linenumber|
        line.strip().split('').reverse.each_with_index do |c,idx|
            results[idx] = results[idx] + c.to_i
            lineLength = idx
        end
        lines = linenumber
    end
    p lines
    gamma = 0
    results[0..lineLength].each_with_index do |count, idx|
        if (count > (lines/2))
            puts "most common for bit #{idx} is 1"
            gamma = gamma + (1 << (idx))
        else
            puts "most common for bit #{idx} is 0"
        end
    end
    epsilon = (1 << (lineLength + 1)) - gamma - 1
    puts "gamma = #{gamma}"
    puts "epsilon = #{epsilon}"
    puts "answer = #{gamma * epsilon}"
end
