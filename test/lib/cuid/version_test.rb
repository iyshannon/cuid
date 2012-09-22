require_relative '../../test_helper'
describe Cuid do
  it "must be defined" do
    Cuid::VERSION.wont_be_nil
  end
end
