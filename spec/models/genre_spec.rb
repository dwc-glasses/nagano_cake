require "spec_helper"

describe "Genre" do
  describe "validation" do
    example "空欄は無効" do
      genre = build(:genre, name: "")
      expect(genre).not_to be_valid
    end
  end
end