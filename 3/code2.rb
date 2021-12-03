def discriminator(lines, cmp, depth=0)
    if lines.count() == 1
        return lines[0].to_i(2)
    else
        set=[]
        unset=[]
        lines.each do |line|
            if (line[depth] == '1')
                set << line
            else
                unset << line
            end
        end
        if (cmp.call(set.count(), unset.count()))
            return popChildren = discriminator(set,cmp,depth+1)
        else
            return popChildren = discriminator(unset,cmp,depth+1)
        end
    end
end

if (ARGV.count != 1)
    puts "Please supply a filename"
else
    lines = File.read(ARGV[0]).split("\n")

    oxygen = discriminator(lines,lambda { |a,b| a >= b })
    co2 = discriminator(lines,lambda { |a,b| a < b })
    puts "Oxygen: #{oxygen}"
    puts "CO2: #{co2}"
    puts "product: #{oxygen * co2}"
end
