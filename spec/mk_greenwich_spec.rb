require 'spec_helper'

describe MkGreenwich do
  it 'has a version number' do
    expect(MkGreenwich::VERSION).not_to be nil
  end

  # 2016-09-06 00:00:00 +00:00 (UTC)
  let(:e) { MkGreenwich::Greenwich.new(Time.new(2016, 9, 6, 0, 0, 0, "+00:00")) }

  context "#new(2016-09-06 00:00:00 +00:00)" do
    context "object" do
      it { expect(e).to be_an_instance_of(MkGreenwich::Greenwich) }
    end
  end
end
