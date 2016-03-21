class BitmapImage
  def initialize(rows, columns)
    rows = rows.to_i
    columns = columns.to_i
    if rows > 0 && columns > 0
      @representation = [ ([0] * columns) ] * rows
    else
      @representation = []
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
end