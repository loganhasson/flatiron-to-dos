class Anagram

  attr_accessor :word

  def initialize(word)
    @word = word
  end

  # def match(anagram_array)
  #   anagram_array.map do |potential|
  #     temp_potential = potential.clone
  #     if potential.length == self.word.length
  #       self.word.each_char do |c|
  #         if potential.include?(c)
  #           potential.sub!(c, "")
  #         end
  #       end
  #       temp_potential if potential.length == 0
  #     end
  #   end.compact
  # end

  # REFACTORED

  def match(anagram_array)
    anagram_array.select {|item| item.chars.sort == self.word.chars.sort}
  end

end