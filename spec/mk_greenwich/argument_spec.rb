require "spec_helper"
require "date"

describe MkGreenwich::Argument do
  context "#self.new(\"20160906125959\")" do
    let(:a) { MkGreenwich::Argument.new("20160906125959") }

    context "object" do
      it { expect(a).to be_an_instance_of(MkGreenwich::Argument) }
    end

    context ".get_utc" do
      subject { a.get_utc }
      it do
        expect(subject).to eq Time.new(2016, 9, 6, 12, 59, 59, "+00:00")
      end
    end
  end

  context "#date-time digit is wrong" do
    let(:a) { MkGreenwich::Argument.new("201609069") }

    context "object" do
      it { expect(a).to be_an_instance_of(MkGreenwich::Argument) }
    end

    context ".get_utc" do
      subject { a.get_utc }
      it { expect(subject).to be_nil }
    end
  end

  context "#invalid date-time" do
    let(:a) { MkGreenwich::Argument.new("20160931") }

    context "object" do
      it { expect(a).to be_an_instance_of(MkGreenwich::Argument) }
    end

    context ".get_utc" do
      subject { a.get_utc }
      it { expect(subject).to be_nil }
    end
  end
end

