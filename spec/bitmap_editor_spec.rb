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

describe 'bitmap_editor' do

  before do
    @editor = BitmapEditor.new
    allow(@editor).to receive(:print) { '' }
  end

  # Creating and Printing an bitmap image

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

  # Coloring

  it 'should show an error when performing command L before an image is created' do
    prepare_for_command 'L 2 2 B'
    expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
    @editor.run
  end

  it 'should color a pixel when input command is L with invalid input' do
    create_3_by_3_image
    prepare_for_command 'L 2 2'
    expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
    expect(STDOUT).to receive(:puts).with(/Help/).ordered
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
    @editor.run
  end

  it 'should color a pixel when input command is L with out of bounds input' do
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

  it 'should color the image row when input command is H with valid input' do
    create_3_by_3_image
    prepare_for_command 'H 1 3 2 B'
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OOO\nBBB\nOOO").ordered
    @editor.run
  end

  it 'should color a pixel when input command is H with out of bounds input' do
    create_3_by_3_image
    prepare_for_command 'H 4 4 4 V'
    expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
    expect(STDOUT).to receive(:puts).with(/Help/).ordered
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
    @editor.run
  end

  it 'should color a pixel when input command is H with invalid input' do
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

  it 'should color the image column when input command is V with valid input' do
    create_3_by_3_image
    prepare_for_command 'V 1 3 2 B'
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OBO\nOBO\nOBO").ordered
    @editor.run
  end

  it 'should color a pixel when input command is V with out of bounds input' do
    create_3_by_3_image
    prepare_for_command 'V 4 4 4 V'
    expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
    expect(STDOUT).to receive(:puts).with(/Help/).ordered
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
    @editor.run
  end

  it 'should color a pixel when input command is V with invalid input' do
    create_3_by_3_image
    prepare_for_command 'V 4 4 V'
    expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
    expect(STDOUT).to receive(:puts).with(/Help/).ordered
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OOO\nOOO\nOOO").ordered
    @editor.run
  end

  it 'should show an error when performing command F before an image is created' do
    prepare_for_command 'F 2 2 B'
    expect(STDOUT).to receive(:puts).with("ERROR: you haven't created an image yet!").ordered
    @editor.run
  end

  it 'should color the image column when input command is F with valid input' do
    create_3_by_3_image
    prepare_for_command 'F 2 2 B'
    @editor.run

    prepare_for_command 'S'
    expect(STDOUT).to receive(:puts).with("OBO\nBBB\nOBO").ordered
    @editor.run
  end
end