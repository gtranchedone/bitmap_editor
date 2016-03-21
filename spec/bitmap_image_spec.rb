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
    expect(image.to_s).to eq '0'
  end

  it 'should start blank with size (2, 1)' do
    image = BitmapImage.new(2, 1)
    expect(image.to_s).to eq "0\n0"
  end

  it 'should start blank with size (2, 2)' do
    image = BitmapImage.new(2, 2)
    expect(image.to_s).to eq "00\n00"
  end

  it 'should start blank with size n by n' do
    size = Random.rand(1...10)
    image = BitmapImage.new(size, size)
    expect(image.to_s).to eq ("#{'0' * size}\n" * size).chomp
  end

  it 'should start blank with size n by m' do
    n = Random.rand(1...10)
    m = Random.rand(1...10)
    image = BitmapImage.new(n, m)
    expect(image.to_s).to eq ("#{'0' * m}\n" * n).chomp
  end

  it 'does not crash if created with invalid parameters' do
    image = BitmapImage.new('foo', 'bar')
    expect(image.to_s).to eq 'Empty image'
  end

  it 'should allow coloring a pixel' do
    image = BitmapImage(3, 3)
    expect(image.to_s).to eq "000\n000\n000"
  end

end