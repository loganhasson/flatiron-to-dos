class SecretHandshake

  attr_accessor :commands, :reverse, :length

  def initialize(code)
    @commands = code.split('')
    if @commands.size == 5
      @reverse = true
      @commands.shift
    else
      @reverse = false
    end
    @length = @commands.size
    puts self.length
  end

  def commands
    i = -1
    @commands = @commands.map do |command|
      i += 1
      if self.length == 1
        "wink" if command.to_i == 1
      elsif self.length == 2
        if i == 0
          "double blink" if command.to_i == 1
        elsif i == 1
          "wink" if command.to_i == 1
        end
      elsif self.length == 3
        if i == 0
          "close your eyes" if command.to_i == 1
        elsif i == 1
          "double blink" if command.to_i == 1
        elsif i == 2
          "wink" if command.to_i == 1
        end
      elsif self.length == 4
        if i == 0
          "jump" if command.to_i == 1
        elsif i == 1
          "close your eyes" if command.to_i == 1
        elsif i == 2
          "double blink" if command.to_i == 1
        elsif i == 3
          "wink" if command.to_i == 1
        end
      end
    end.compact

    if self.reverse
      @commands
    else
      @commands.reverse
    end
  end
end