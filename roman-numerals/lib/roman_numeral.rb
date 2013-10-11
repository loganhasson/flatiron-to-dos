require 'sqlite3'

class Integer

  @@db = SQLite3::Database.new('numerals.db')

  TABLES = ["thousands", "hundreds", "tens", "ones"]

  def tables
    TABLES
  end

  def pad_me
    num_array = self.to_s.each_char.map {|c| c}
    ["0"]*(4 - num_array.size) + num_array
  end

  def to_roman
    self.pad_me.each_with_index.map do |num, i|
      if num != "0"
        sql = "SELECT result FROM #{self.tables[i]} WHERE id = ?"
        @@db.execute(sql, num.to_i)
      end
    end.join
  end

end