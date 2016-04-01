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
        when 'H'
          color_row params
        when 'V'
          color_column params
        when 'F'
          color_region params
        when 'R'
          color_rect params
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

    def valid_params?(params, min_count = 2)
      return false if params.count < min_count
      rows     = params[1].to_i
      cols     = params[2].to_i
      max_size = BitmapImage::MAX_SIZE
      rows > 0 && rows <= max_size && cols > 0 && cols <= max_size
    end

    def create_image(params)
      if valid_params?(params)
        # parameters start with are columns and rows
        @image = BitmapImage.new(params[2].to_i, params[1].to_i)
        puts 'Image created'
      else
        show_invalid_params_help
      end
    end

    def color_pixel(params)
      if @image.nil?
        show_message_for_no_image
      else
        # parameters start with are column, row, color
        unless @image.color_pixel(params[2].to_i, params[1].to_i, params[3])
          show_invalid_params_help
        end
      end
    end

    def color_row(params)
      if @image.nil?
        show_message_for_no_image
      else
        # parameters start with are start_column, end_column, row, color
        unless @image.color_row(params[3].to_i, params[1].to_i, params[2].to_i, params[4])
          show_invalid_params_help
        end
      end
    end

    def color_column(params)
      if @image.nil?
        show_message_for_no_image
      else
        # parameters start with are column, start_row, end_row, color
        unless @image.color_column(params[1].to_i, params[2].to_i, params[3].to_i, params[4])
          show_invalid_params_help
        end
      end
    end

    def color_region(params)
      if @image.nil?
        show_message_for_no_image
      else
        # parameters start with are column, row
        unless @image.color_region(params[2].to_i, params[1].to_i, params[3])
          show_invalid_params_help
        end
      end
    end

    def color_rect(params)
      if @image.nil?
        show_message_for_no_image
      else
        # parameters start with are column1, row1, column2, row2, color
        unless @image.color_rect(params[2].to_i, params[1].to_i, params[4].to_i, params[3].to_i, params[5])
          show_invalid_params_help
        end
      end
    end

    def clear_image
      @image.clear unless @image.nil?
    end

    def show_image
      @image.nil? ? show_message_for_no_image : puts(@image.to_s)
    end

    def show_message_for_no_image
      puts "ERROR: you haven't created an image yet!"
    end

    def show_invalid_params_help
      puts 'Invalid parameters. Usage:'
      show_help
    end

    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts '? - Help
An image needs to have at least 1 row and column and at most 250 rows and columns.
Rows and columns start at index 1 and end at index N.
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
F X Y C - Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
R X1 Y1 X2 Y2 C - Draw a rectangle where (X1, Y1) and (X2, Y2) are the coordinates of two corners representing the
rectangle and C is the color to use. A rectangle drawn this way is not filled.
S - Show the contents of the current image
X - Terminate the session'
    end
end
