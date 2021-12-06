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

    def isDiagonal?
        return (@start[:x]- @end[:x]).abs == (@start[:y]- @end[:y]).abs
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
    (0..max_x).each do |x|
        points << Array.new(max_y+1,0)
    end

    lines.each do |l|
        #puts l
        if (l.isHorizontal?)
            #puts "horizontal"
            rng = (l.min_y < l.max_y) ? (l.min_y..l.max_y) : (l.max_y..l.min_y)
            rng.each do |y|
                #puts "#{l.max_x},#{y}"
                points[l.max_x][y] = points[l.max_x][y]+1
            end
        end
        if (l.isVertical?)
            #puts "vertical"
            rng = (l.min_x < l.max_x) ? (l.min_x..l.max_x) : (l.max_x..l.min_x)
            rng.each do |x|
                #puts "#{x},#{l.max_y}"
                points[x][l.max_y] = points[x][l.max_y]+1
            end
        end
        if (l.isDiagonal?)
            #puts "diagonal"
            length = l.end[:x] - l.start[:x] # horizontal/vertical length
            step_y = l.start[:y] < l.end[:y] ? 1 : -1
            y_pos  = l.start[:y]
            rng = l.start[:x] < l.end[:x] ? (l.start[:x]..l.end[:x]) : (l.end[:x]..l.start[:x])
            if (l.start[:x] > l.end[:x])
                step_y = -step_y
                y_pos = l.end[:y]
            end
            #puts rng
            #puts step_y
            rng.each do |x|
                #puts "#{x},#{y_pos}"
                points[x][y_pos] = points[x][y_pos]+1
                y_pos = y_pos + step_y
            end
        end
        puts
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