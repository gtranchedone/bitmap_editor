class BitmapImage
  MAX_SIZE = 250

  def initialize(rows, columns)
    if rows > 0 && rows <= MAX_SIZE && columns > 0 && columns <= MAX_SIZE
      @representation = Array.new(rows, 'O')
      (0...rows).each do |row|
        @representation[row] = Array.new(columns, 'O')
      end
    else
      @representation = []
    end
  end

  def color_pixel(row, column, color)
    return false unless valid_params(row, column, color)
    actual_row = @representation[row - 1]
    actual_row[column - 1] = color.upcase
    true
  end

  def clear
    (0...@representation.count).each do |row_index|
      row = @representation[row_index]
      (0...row.count).each do |column_index|
        row[column_index] = 'O'
      end
    end
  end

  def empty?
    @representation.empty?
  end

  def to_s
    if empty?
      return 'Empty image'
    end
    s = ''
    @representation.each do |row|
      s << "#{row.join('')}\n"
    end
    s.chomp
  end

  private
    def valid_params(row, column, color = '')
      return false unless row.is_a? Integer
      return false unless column.is_a? Integer
      return false unless color.is_a?(String) && color.length == 1
      !out_of_bounds?(row, column)
    end

    def out_of_bounds?(row, column)
      if row > 0 && row <= @representation.count
        actual_row = @representation[row - 1]
        if column > 0 && column <= actual_row.count
          return false
        end
      end
      true
    end
end