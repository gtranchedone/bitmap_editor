require 'rspec'
require_relative '../app/bitmap_editor'

describe 'editor' do

  before do
    @editor = BitmapEditor.new
    allow(@editor).to receive(:print) { '' }
  end

  it 'should print an message when user tries to print the image if it wan not yet created' do
    allow(@editor).to receive(:gets).and_return 'S'
    allow(@editor).to receive(:running?).and_return false
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
    expect(STDOUT).to receive(:puts).with('No image created').ordered
    @editor.run
  end

  it 'should print the image when user wants to do so after an image was created' do
    allow(@editor).to receive(:gets).and_return 'I 3 3'
    allow(@editor).to receive(:running?).and_return false
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
    expect(STDOUT).to receive(:puts).with('Image created').ordered
    @editor.run

    allow(@editor).to receive(:gets).and_return 'S'
    allow(@editor).to receive(:running?).and_return false
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
    expect(STDOUT).to receive(:puts).with("000\n000\n000").ordered
    @editor.run
  end

  it 'should print an error if user tries to create a bitmap image with no dimensions' do
    allow(@editor).to receive(:gets).and_return 'I'
    allow(@editor).to receive(:running?).and_return false
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
    expect(STDOUT).to receive(:puts).with(/Invalid parameters/).ordered
    expect(STDOUT).to receive(:puts).with(/Help/).ordered
    @editor.run
  end

  it 'should print an message after user creates a bitmap image' do
    allow(@editor).to receive(:gets).and_return 'I 3 3'
    allow(@editor).to receive(:running?).and_return false
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
    expect(STDOUT).to receive(:puts).with('Image created').ordered
    @editor.run
  end
end