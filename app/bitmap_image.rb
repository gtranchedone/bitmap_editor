class BitmapImage
  def initialize(rows, columns)
    rows = rows.to_i
    columns = columns.to_i
    if rows > 0 && rows <= 250 && columns > 0 && columns <= 250
      @representation = []
      (0...rows).each do |row|
        @representation[row] = ['O'] * columns
      end
    else
      @representation = []
    end
  end

  def color_pixel(row, column, color)
    row = row.to_i
    column = column.to_i
    unless color.is_a?(String) && !out_of_bounds?(row, column)
      return
    end
    actual_row = @representation[row - 1]
    actual_row[column - 1] = color.upcase
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