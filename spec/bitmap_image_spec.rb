require 'rspec'
require_relative '../app/bitmap_image'

describe 'bitmap_image' do

  it 'is empty if has no rows' do
    image = BitmapImage.new(0, 5)
    expect(image.empty?).to be_truthy
  end

  it 'is empty if has no columns' do
    image = BitmapImage.new(5, 0)
    expect(image.empty?).to be_truthy
  end

  it 'is empty if has too many rows' do
    image = BitmapImage.new(251, 5)
    expect(image.empty?).to be_truthy
  end

  it 'is empty if has too many columns' do
    image = BitmapImage.new(5, 251)
    expect(image.empty?).to be_truthy
  end

  it 'is not empty if has rows and columns' do
    image = BitmapImage.new(2, 5)
    expect(image.empty?).to be_falsey
  end

  it 'should not be valid with size (0, 0)' do
    image = BitmapImage.new(0, 0)
    expect(image.to_s).to eq 'Empty image'
  end

  it 'should start blank with size (0, 1)' do
    image = BitmapImage.new(0, 1)
    expect(image.to_s).to eq 'Empty image'
  end

  it 'should start blank with size (1, 0)' do
    image = BitmapImage.new(1, 0)
    expect(image.to_s).to eq 'Empty image'
  end

  it 'should start blank with size (1, 1)' do
    image = BitmapImage.new(1, 1)
    expect(image.to_s).to eq 'O'
  end

  it 'should start blank with size (2, 1)' do
    image = BitmapImage.new(2, 1)
    expect(image.to_s).to eq "O\nO"
  end

  it 'should start blank with size (2, 2)' do
    image = BitmapImage.new(2, 2)
    expect(image.to_s).to eq "OO\nOO"
  end

  it 'should start blank with size n by n' do
    size = Random.rand(1...10)
    image = BitmapImage.new(size, size)
    expect(image.to_s).to eq ("#{'O' * size}\n" * size).chomp
  end

  it 'should start blank with size n by m' do
    n = Random.rand(1...10)
    m = Random.rand(1...10)
    image = BitmapImage.new(n, m)
    expect(image.to_s).to eq ("#{'O' * m}\n" * n).chomp
  end

  it 'should allow coloring a pixel' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(2, 2, 'r')).to be_truthy
    expect(image.to_s).to eq "OOO\nORO\nOOO"
  end

  it 'should not allow coloring a pixel with row out of bounds' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(-2, 2, 'R')).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should not allow coloring a pixel with column out of bounds' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(2, -2, 'R')).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should not allow coloring a pixel with row out of bounds for excess' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(4, 2, 'R')).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should not allow coloring a pixel with column out of bounds for excess' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(2, 4, 'R')).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should not allow coloring a pixel for non string colors' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(2, 3, 5)).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should not allow coloring a pixel for colors represented by long strings' do
    image = BitmapImage.new(3, 3)
    expect(image.color_pixel(2, 3, 'ab')).to be_falsey
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

  it 'should clear colored pixels' do
    image = BitmapImage.new(3, 3)
    image.color_pixel(2, 2, 'b')
    expect(image.to_s).to eq "OOO\nOBO\nOOO"
    image.clear
    expect(image.to_s).to eq "OOO\nOOO\nOOO"
  end

end