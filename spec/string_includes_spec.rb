require_relative '../lib/string_includes'

describe "string_contains" do
  it "returns true if given two strings the first one is contained in the second one" do
    expect(str_includes("app", "apples")).to eq true
    expect(str_includes("fdsafasfasfs", "ljkljrewfn,msafdsafasfasfsjkljkj")).to eq true
    expect(str_includes("CAPITAL", "fdsfsafcapitalfdasfas")).to eq true
    expect(str_includes("fail", "apples")).to eq false
    expect(str_includes("aaaaaaaa", "bbbbb")).to eq false
  end
end
