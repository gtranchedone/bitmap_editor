require_relative 'bitmap_image'

class BitmapEditor
  def run
    @running = true
    puts 'type ? for help'
    begin
      print '> '
      input = gets.chomp
      params = params_from input
      case params.first
        when '?'
          show_help
        when 'X'
          exit_console
        when 'S'
          show_image
        when 'I'
          create_image params
        when 'L'
          color_pixel params
        when 'C'
          clear_image
        else
          puts 'unrecognised command :('
      end
    end while running?
  end

  def running?
    @running
  end

  private
    def params_from(input)
      input.split(' ')
    end

    def create_image(params)
      if params.count < 3
        puts 'Invalid parameters. Usage:'
        show_help
      else
        @image = BitmapImage.new(params[1], params[2])
        puts 'Image created'
      end
    end

    def color_pixel(params)
      if params.count < 4
        puts 'Invalid parameters. Usage:'
        show_help
      elsif @image.nil?
        show_message_for_no_image
      else
        @image.color_pixel(params[1], params[2], params[3])
      end
    end

    def clear_image
      @image.clear unless @image.nil?
    end

    def show_image
      @image.nil? ? show_message_for_no_image : puts(@image.to_s)
    end

    def show_message_for_no_image
      puts 'No image created'
    end

    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts '? - Help
An image needs to have at least 1 row and column and at most 250 rows and columns.
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
F X Y C - Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
S - Show the contents of the current image
X - Terminate the session'
    end
end