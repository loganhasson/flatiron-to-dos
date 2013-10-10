class Person

  attr_accessor :name, :birthday, :hair_color, :eye_color, :height, :weight,
                :handed, :complexion, :t_shirt_size, :wrist_size, :glove_size,
                :pant_length, :pant_width

  def initialize(data)
    data.each do |attrib, value|
      self.send("#{attrib}=", value)
    end
  end

  # def initialize(data)
  #   data.each do |attrib, val|
  #     self.instance_variable_set("@#{attrib}", val)
  #   end
  # end

end