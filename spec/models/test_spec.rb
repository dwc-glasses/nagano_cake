require "spec_helper"

describe String do
  example "ใในใ" do
    s = "ABC"
    s << "D"
    expect(s.size).to eq(4)
  end
end