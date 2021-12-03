
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    lines = File.read(ARGV[0]).split("\n")
    lineCount = lines.length()
    lineLength = lines[0].length()  # assume all lines are equal length
    results = Array.new(lineLength,0)

    lines.each do |line|
        line.split('').reverse.each_with_index do |c,idx|
            results[idx] = results[idx] + c.to_i
        end
    end
    p lineCount
    gamma = 0
    results[0...lineLength].each_with_index do |count, idx|
        if (count > (lineCount/2))
            puts "most common for bit #{idx} is 1"
            gamma = gamma + (1 << (idx))
        else
            puts "most common for bit #{idx} is 0"
        end
    end
    epsilon = (1 << lineLength) - gamma - 1
    puts "gamma = #{gamma}"
    puts "epsilon = #{epsilon}"
    puts "answer = #{gamma * epsilon}"
end
