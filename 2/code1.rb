
if (ARGV.count != 1)
    puts "Please supply a filename"
else
    depth   = 0
    forward = 0
    File.open(ARGV[0]).each do |line|
        parts = line.split
        case parts[0]
        when "forward"
            forward = forward + parts[1].to_i
        when "down"
            depth = depth + parts[1].to_i
        when "up"
            depth = depth - parts[1].to_i
        end
    end
    puts forward
    puts depth
    puts depth * forward
end
