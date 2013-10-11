require 'sqlite3'

class Integer

  @@db = SQLite3::Database.new('numerals.db')

  TABLES = ["thousands", "hundreds", "tens", "ones"]

  def tables
    TABLES
  end

  def pad_me
    num_array = self.to_s.each_char.map {|c| c}
    until num_array.size == 4
      num_array.unshift("0")
    end

    num_array
  end

  def to_roman
    r_numeral = self.pad_me.each_with_index.map do |num, i|
      if num == "0"
        nil
      else
        sql = "SELECT result FROM #{self.tables[i]} WHERE id = ?"
        @@db.execute(sql, num.to_i).first.flatten
      end
    end.compact

    r_numeral.join('')
  end

end