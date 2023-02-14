require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movie) { create(:movie) }

  describe 'relationships' do
    describe 'with categories' do
      let!(:category) { create(:category) }
      let!(:category_movie) { create(:category_movie, category: category, movie: movie) }

      it 'has many category_movies' do
        expect(movie.category_movies).to include(category_movie)
      end

      it 'has many categories through category_movies' do
        expect(movie.categories).to include(category)
      end
    end

    describe 'with ratings' do
      let!(:rating) { create(:rating, movie: movie) }

      it "has many ratings" do
        expect(movie.ratings).to include(rating)
      end

      it "destroys dependent ratings" do
        expect { movie.destroy }.to change { Rating.count }.by(-1)
      end
    end
  end

  describe "validations" do
    def valid_file
      file = Tempfile.new(["valid_file", ".png"], content_type: "image/png")
      file.truncate(2.megabytes - 1)

      blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "valid_file.png")

      file.close
      file.unlink

      blob
    end

    def invalid_file
      file = Tempfile.new(["invalid_file", ".pdf"], content_type: "application/pdf")
      file.truncate(2.megabytes - 1)

      blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "invalid_file.pdf")

      file.close
      file.unlink

      blob
    end

    def big_file
      file = Tempfile.new(["big_file", ".jpg"], content_type: "image/jpg")
      file.truncate(2.megabytes + 1)

      blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "big_file.jpg")

      file.close
      file.unlink

      blob
    end

    it "is valid with valid attributes" do
      expect(movie).to be_valid
    end

    it "is not valid without a title" do
      movie.title = nil
      expect(movie).to_not be_valid
    end

    it "is not valid without a year" do
      movie.year = nil
      expect(movie).to_not be_valid
    end

    it "is not valid without an average rating" do
      movie.average_rating = nil
      expect(movie).to_not be_valid
    end

    it "is not valid with average rating less than 0" do
      movie.average_rating = -1
      expect(movie).to_not be_valid
    end

    it "is not valid with average rating greater than 10" do
      movie.average_rating = 11
      expect(movie).to_not be_valid
    end

    it "is valid with an image" do
      movie.update(image: valid_file)

      expect(movie).to be_valid
    end

    it "is not valid without an image" do
      movie.image.purge

      expect(movie).to_not be_valid
    end

    it "is not valid with image larger than 2 MB" do
      movie.update(image: big_file)

      expect(movie).to_not be_valid
      expect(movie.errors[:image]).to include("too big")
    end

    it "is not valid with image other than jpg, jpeg or png" do
      movie.update(image: invalid_file)

      expect(movie).to_not be_valid
      expect(movie.errors[:image]).to include("has an invalid content type")
    end
  end
end
