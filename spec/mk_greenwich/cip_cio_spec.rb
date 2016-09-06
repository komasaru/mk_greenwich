require "spec_helper"

describe MkGreenwich::CipCio do
  context ".new(0.16680355920602327)" do
    let(:c) { MkGreenwich::CipCio.new(0.16680355920602327) }

    context "object" do
      it { expect(c).to be_an_instance_of(MkGreenwich::CipCio) }
    end

    context "@t" do
      it { expect(c.instance_variable_get(:@t)).to eq 0.16680355920602327 }
    end

    context ".bpn2xy" do
      let(:r) { [
        [0.9999918271499867,    -0.0037080294810666083, -0.0016112574588758337 ],
        [0.0037080946537372344,  0.9999931242916492,     3.7462851217048895e-05],
        [0.0016111074669827113, -4.343724020765925e-05,  0.9999987012221245    ]
      ] }
      subject { c.bpn2xy(r) }
      it { expect(subject).to match([0.0016111074669827113, -4.343724020765925e-05]) }
    end

    context ".calc_s_06" do
      let(:x) { 0.0016111074669827113  }
      let(:y) { -4.343724020765925e-05 }
      subject { c.calc_s_06(x, y) }
      it { expect(subject).to be_within(1.0e-23).of(3.318483384770641e-08) }
    end
  end
end

