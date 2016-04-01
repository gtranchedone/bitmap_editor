require 'rspec'
require_relative '../app/bitmap_editor'

def prepare_for_command(command)
  allow(@editor).to receive(:gets).and_return command
  allow(@editor).to receive(:running?).and_return false
  expect(STDOUT).to receive(:puts).with('type ? for help').ordered
end

def create_3_by_3_image
  prepare_for_command 'I 3 3'
  expect(STDOUT).to receive(:puts).with('Image created').ordered
  @editor.run
end

def create_5_by_6_image
  prepare_for_command 'I 5 6'
  expect(STDOUT).to receive(:puts).with('Image created').ordered
  @editor.run
end

describe 'bitmap_editor' do

  before do
    @editor = BitmapEditor.new
    allow(@editor).to receive(:print) { '' }
  end

  context "when creating and printing an bitmap image" do
    it 'should print an message when user tries to print the image if it wan not yet created' do
      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should print the image when user wants to do so after an image was created' do
      create_3_by_3_image
      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should print an error if user tries to create a bitmap image with no dimensions' do
      prepare_for_command 'I'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run
    end
  end

  context "when coloring" do
    it 'should show an error when performing command L before an image is created' do
      prepare_for_command 'L 2 2 B'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should not color a pixel when input command is L with invalid input' do
      create_3_by_3_image
      prepare_for_command 'L 2 2'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should not color a pixel when input command is L with out of bounds input' do
      create_3_by_3_image
      prepare_for_command 'L 2 4 R'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should color a pixel when input command is L with valid input' do
      create_3_by_3_image
      prepare_for_command 'L 2 2 B'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOBO\nOOO").ordered
      @editor.run
    end

    it 'should color a pixel when input command is L with valid input (larger)' do
      create_5_by_6_image
      prepare_for_command 'L 2 3 A'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOOOO\nOOOOO\nOAOOO\nOOOOO\nOOOOO\nOOOOO").ordered
      @editor.run
    end

    it 'should clear the image when input command is C' do
      create_3_by_3_image
      prepare_for_command 'L 2 2 B'
      @editor.run

      prepare_for_command 'C'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should show an error when performing command H before an image is created' do
      prepare_for_command 'H 1 3 2 B'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should color color not color a horizontal line when input command is H with valid input' do
      create_3_by_3_image
      prepare_for_command 'H 1 3 2 B'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nBBB\nOOO").ordered
      @editor.run
    end

    it 'should not color color not color a horizontal line when input command is H with out of bounds input' do
      create_3_by_3_image
      prepare_for_command 'H 4 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should not color not color a horizontal line when input command is H with invalid input' do
      create_3_by_3_image
      prepare_for_command 'H 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should show an error when performing command V before an image is created' do
      prepare_for_command 'V 1 3 2 B'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should not color a vertical line when input command is V with valid input' do
      create_3_by_3_image
      prepare_for_command 'V 2 1 3 B'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OBO\nOBO\nOBO").ordered
      @editor.run
    end

    it 'should not color a vertical line when input command is V with out of bounds input' do
      create_3_by_3_image
      prepare_for_command 'V 4 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should not color a vertical line when input command is V with invalid input' do
      create_3_by_3_image
      prepare_for_command 'V 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should perform the right actions for V command followed by H command' do
      create_5_by_6_image
      prepare_for_command 'V 2 3 6 W'
      @editor.run

      prepare_for_command 'H 3 5 2 Z'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOOOO\nOOZZZ\nOWOOO\nOWOOO\nOWOOO\nOWOOO").ordered
      @editor.run
    end

    it 'should show an error when performing command F before an image is created' do
      prepare_for_command 'F 2 2 B'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should color the correct range when performing the F command with valid input on a large image' do
      create_5_by_6_image
      prepare_for_command 'F 1 1 W'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("WWWWW\nWWWWW\nWWWWW\nWWWWW\nWWWWW\nWWWWW").ordered
      @editor.run
    end

    it 'should color the correct range when performing the F command with valid input' do
      create_3_by_3_image
      prepare_for_command 'H 1 3 1 B'
      @editor.run

      prepare_for_command 'F 2 2 R'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("BBB\nRRR\nRRR").ordered
      @editor.run
    end

    it 'should not color not a region starting at a point out of bounds but should show the help instead' do
      create_3_by_3_image
      prepare_for_command 'F 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end
  end

  context "when coloring a rectangle" do
    it 'should not color not anything when first point is out of bounds but should show the help instead' do
      create_3_by_3_image
      prepare_for_command 'R 4 4 1 1 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should not color not anything when second point is out of bounds but should show the help instead' do
      create_3_by_3_image
      prepare_for_command 'R 1 1 4 4 V'
      expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
      expect(STDOUT).to receive(:puts).with(/Help/).ordered
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
      @editor.run
    end

    it 'should not color the rect if the parameters are valid but no image was previously created' do
      prepare_for_command 'R 1 1 3 3 V'
      expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
      @editor.run
    end

    it 'should stroke a rect using the passed in color if the parameters are valid' do
      create_3_by_3_image
      prepare_for_command 'R 1 1 3 3 V'
      @editor.run

      prepare_for_command 'S'
      expect(STDOUT).to receive(:puts).with("VVV\nVOV\nVVV").ordered
      @editor.run
    end
  end
end
