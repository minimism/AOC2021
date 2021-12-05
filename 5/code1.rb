class Line
    attr_accessor :start, :end

    def initialize(str)
        m = /(\d+),(\d+)\s*->\s*(\d+),(\d+)/
        all = str.match(m)
        @start = {:x => all[1].to_i, :y => all[2].to_i}
        @end = {:x => all[3].to_i, :y => all[4].to_i}
    end

    def isHorizontal?
        return @start[:x] == @end[:x]
    end

    def isVertical?
        return @start[:y] == @end[:y]
    end

    def to_s
        return "#{@start[:x]},#{@start[:y]} : #{@end[:x]},#{@end[:y]}"
    end

    def max_x
        mx = 0
        if (@start[:x] > mx)
            mx = @start[:x]
        end
        if (@end[:x] > mx)
            mx = @end[:x]
        end
        return mx
    end

    def min_x
        mx = max_x
        if (@start[:x] < mx)
            mx = @start[:x]
        end
        if (@end[:x] < mx)
            mx = @end[:x]
        end
        return mx
    end

    def max_y
        my = 0
        if (@start[:y] > my)
            my = @start[:y]
        end
        if (@end[:y] > my)
            my = @end[:y]
        end
        return my
    end

    def min_y
        my = max_y
        if (@start[:y] < my)
            my = @start[:y]
        end
        if (@end[:y] < my)
            my = @end[:y]
        end
        return my
    end
end

if (ARGV.count != 1)
    puts "Please supply a filename"
else
    lines = []
    text = File.read(ARGV[0]).split("\n")
    text.each do |l|
        line = Line.new(l)
        lines << line
    end

    max_x = 0
    max_y = 0
    lines.each do |l|
        max_x = l.max_x if (l.max_x > max_x)
        max_y = l.max_y if (l.max_y > max_y)
    end
    puts "#{max_x},#{max_y}"

    points = []
    (0..max_y+1).each do |y|
        points << Array.new(max_x+2,0)
    end
    lines.each do |l|
        if (l.isHorizontal?)
            (l.min_y..l.max_y).each do |y|
                #puts "#{l.max_x},#{y}"
                points[l.max_x][y] = points[l.max_x][y]+1
            end
        end
        if (l.isVertical?)
            (l.min_x..l.max_x).each do |x|
#                puts "#{x},#{l.max_y}"
                points[x][l.max_y] = points[x][l.max_y]+1
            end
        end
    end
#    puts "------"
#    points.each do |p|
#        p p
#    end
#    puts "------"
    crossover=0
    points.each do |p|
        p.each do |a|
            if (a>1)
                crossover = crossover + 1
            end
        end
    end
    puts crossover
end