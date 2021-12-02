
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    depth   = 0
    forward = 0
    aim     = 0
    File.open(ARGV[0]).each do |line|
        parts = line.split

        num = parts[1].to_i

        case parts[0]
        when "forward"
            forward = forward + num
            depth = depth + aim * num
        when "down"
            aim = aim + num
        when "up"
            aim = aim - num
        end
    end
    puts forward
    puts depth
    puts depth * forward
end
