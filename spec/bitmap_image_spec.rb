require 'rspec'
require_relative '../app/bitmap_image'

describe 'bitmap_image' do

  before do
    @image = BitmapImage.new(3, 3)
  end

  context "when initializing" do
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
  end

  context "when drawing a pixel" do
    it 'should allow coloring a pixel' do
      expect(@image.color_pixel(2, 2, 'r')).to be_truthy
      expect(@image.to_s).to eq "OOO\nORO\nOOO"
    end

    it 'should not allow coloring a pixel with row < 0' do
      expect(@image.color_pixel(-2, 2, 'R')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel with column < 0' do
      expect(@image.color_pixel(2, -2, 'R')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel with row > size' do
      expect(@image.color_pixel(4, 2, 'R')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel with column > size' do
      expect(@image.color_pixel(2, 4, 'R')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel for non string colors' do
      expect(@image.color_pixel(2, 3, 5)).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel for string colors that do not contain letters' do
      expect(@image.color_pixel(2, 3, '5')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a pixel for colors represented by long strings' do
      expect(@image.color_pixel(2, 3, 'ab')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should clear colored pixels' do
      @image.color_pixel(2, 2, 'b')
      expect(@image.to_s).to eq "OOO\nOBO\nOOO"
      @image.clear
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end
  end

  context "when coloring a horizontal line" do
    it 'should allow coloring a horizontal line' do
      expect(@image.color_row(2, 1, 3, 'r')).to be_truthy
      expect(@image.to_s).to eq "OOO\nRRR\nOOO"
    end

    it 'should allow coloring a horizontal line with reverse input' do
      expect(@image.color_row(2, 3, 1, 'r')).to be_truthy
      expect(@image.to_s).to eq "OOO\nRRR\nOOO"
    end

    it 'should allow to partially color a horizontal line' do
      expect(@image.color_row(1, 1, 2, 'r')).to be_truthy
      expect(@image.to_s).to eq "RRO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when row <= 0' do
      expect(@image.color_row(0, 3, 3, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when row < size' do
      expect(@image.color_row(4, 3, 3, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when start_column <= 0' do
      expect(@image.color_row(1, 0, 3, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when start_column > size' do
      expect(@image.color_row(1, 4, 3, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when end_column <= 0' do
      expect(@image.color_row(1, 3, 0, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a horizontal line when end_column > size' do
      expect(@image.color_row(1, 3, 4, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end
  end

  context "when coloring a vertical line" do
    it 'should allow coloring a vertical line' do
      expect(@image.color_column(1, 1, 3, 'r')).to be_truthy
      expect(@image.to_s).to eq "ROO\nROO\nROO"
    end

    it 'should allow coloring a vertical line with reverse imput' do
      expect(@image.color_column(1, 3, 1, 'r')).to be_truthy
      expect(@image.to_s).to eq "ROO\nROO\nROO"
    end

    it 'should allow to partially color a vertical line' do
      expect(@image.color_column(2, 2, 3, 'r')).to be_truthy
      expect(@image.to_s).to eq "OOO\nORO\nORO"
    end

    it 'should not allow coloring a vertical line when column <= 0' do
      expect(@image.color_column(0, 3, 1, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a vertical line when column > size' do
      expect(@image.color_column(4, 3, 1, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a vertical line when start_row <= 0' do
      expect(@image.color_column(3, 0, 1, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a vertical line when start_row > size' do
      expect(@image.color_column(3, 4, 1, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a vertical line when end_row <= 0' do
      expect(@image.color_column(3, 1, 0, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not allow coloring a vertical line when end_row > size' do
      expect(@image.color_column(3, 1, 4, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end
  end

  context "when coloring a region" do
    it 'should not color a region if pixel has row <= 0' do
      expect(@image.color_region(0, 2, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not color a region if pixel has row > size' do
      expect(@image.color_region(4, 2, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not color a region if pixel has column <= 0' do
      expect(@image.color_region(2, 0, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not color a region if pixel has column > size' do
      expect(@image.color_region(2, 4, 'r')).to be_falsey
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
    end

    it 'should not color a region if the image is empty' do
      @image = BitmapImage.new(0, 0)
      expect(@image.color_region(2, 4, 'r')).to be_falsey
      expect(@image.to_s).to eq 'Empty image'
    end

    it 'should color a region by coloring a pixel and recursively its neighbours with the same color (empty image)' do
      expect(@image.to_s).to eq "OOO\nOOO\nOOO"
      expect(@image.color_region(2, 2, 'r')).to be_truthy
      expect(@image.to_s).to eq "RRR\nRRR\nRRR"
    end

    it 'should color a region by coloring a pixel and recursively its neighbours with the same color (empty large image)' do
      @image = BitmapImage.new(5, 6)
      expect(@image.to_s).to eq "OOOOOO\nOOOOOO\nOOOOOO\nOOOOOO\nOOOOOO"
      expect(@image.color_region(1, 1, 'r')).to be_truthy
      expect(@image.to_s).to eq "RRRRRR\nRRRRRR\nRRRRRR\nRRRRRR\nRRRRRR"
    end

    it 'should color a region by coloring a pixel and recursively its neighbours with the same color (one row pre-colored)' do
      @image.color_row(1, 1, 3, 'B')
      expect(@image.color_region(2, 2, 'r')).to be_truthy
      expect(@image.to_s).to eq "BBB\nRRR\nRRR"
    end

    it 'should color a region by coloring a pixel and recursively its neighbours with the same color (corners only)' do
      @image.color_pixel(1, 2, 'B')
      @image.color_pixel(3, 2, 'B')
      @image.color_pixel(2, 1, 'B')
      @image.color_pixel(2, 3, 'B')
      expect(@image.to_s).to eq "OBO\nBOB\nOBO"
      expect(@image.color_region(2, 2, 'r')).to be_truthy
      expect(@image.to_s).to eq "RBR\nBRB\nRBR"
    end

    it 'should color a region by coloring a pixel and recursively its neighbours with the same color (mixed)' do
      @image = BitmapImage.new(7, 6)
      @image.color_row(1, 1, 6, 'G')
      @image.color_row(2, 1, 6, 'B')
      @image.color_pixel(3, 3, 'G')
      @image.color_pixel(3, 4, 'G')
      @image.color_pixel(4, 5, 'G')
      @image.color_pixel(5, 6, 'G')
      @image.color_pixel(6, 1, 'G')
      @image.color_row(6, 5, 6, 'G')
      @image.color_row(7, 2, 4, 'G')
      expect(@image.to_s).to eq "GGGGGG\nBBBBBB\nOOGGOO\nOOOOGO\nOOOOOG\nGOOOGG\nOGGGOO"
      expect(@image.color_region(6, 1, 'R')).to be_truthy
      expect(@image.to_s).to eq "GGGGGG\nBBBBBB\nOORROO\nOOOORO\nOOOOOR\nROOORR\nORRROO"
    end
  end
end
