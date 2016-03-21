class BitmapImage
  MAX_SIZE = 250
  DEFAULT_COLOR = 'O'

  def initialize(rows, columns)
    if rows > 0 && rows <= MAX_SIZE && columns > 0 && columns <= MAX_SIZE
      @representation = Array.new(rows, DEFAULT_COLOR)
      (0...rows).each do |row|
        @representation[row] = Array.new(columns, DEFAULT_COLOR)
      end
    else
      @representation = []
    end
  end

  def color_pixel(row, column, color = 'O')
    return false unless valid_params(row, column, color)
    # adjust parameters for internal representation
    actual_row = @representation[row - 1]
    actual_row[column - 1] = color.upcase
    true
  end

  def color_row(row, start_col, end_col, color = 'O')
    return false unless valid_params(row, start_col, color) && valid_params(row, end_col)
    (start_col..end_col).each do |col|
      color_pixel row, col, color
    end
    true
  end

  def color_column(col, start_row, end_row, color = 'O')
    return false unless valid_params(start_row, col, color) && valid_params(end_row, col)
    (start_row..end_row).each do |row|
      color_pixel row, col, color
    end
    true
  end

  def color_region(row, column, color = 'O')
    return false unless color_pixel row, column, color
    color_pixel row - 1, column, color
    color_pixel row, column - 1, color
    color_pixel row + 1, column, color
    color_pixel row, column + 1, color
    true
  end

  def clear
    (0...@representation.count).each do |row_index|
      row = @representation[row_index]
      (0...row.count).each do |column_index|
        row[column_index] = DEFAULT_COLOR
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
    def valid_params(row, column, color = DEFAULT_COLOR)
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