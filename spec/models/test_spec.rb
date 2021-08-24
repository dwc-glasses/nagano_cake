require "spec_helper"

describe String do
  example "テスト" do
    s = "ABC"
    s << "D"
    expect(s.size).to eq(4)
  end
end