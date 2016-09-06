require "spec_helper"

describe MkGreenwich::EraEors do
  context ".new(2457637.499988426)" do
    let(:e) { MkGreenwich::EraEors.new(2457637.499988426) }

    context "object" do
      it { expect(e).to be_an_instance_of(MkGreenwich::EraEors) }
    end

    context "@jd" do
      it { expect(e.instance_variable_get(:@jd)).to eq 2457637.499988426 }
    end

    context "@t" do
      it { expect(e.instance_variable_get(:@t)).to eq 6092.499988425989 }
    end

    context ".calc_era" do
      let(:jd) { 2457637.5 }
      let(:t)  { 6092.499988425989 }
      subject { e.calc_era(jd, t) }
      it { expect(subject).to eq 6.026682507434728 }
    end

    context ".calc_eo" do
      let(:r_mtx) { [
        [0.9999918271499867,    -0.0037080294810666083, -0.0016112574588758337 ],
        [0.0037080946537372344,  0.9999931242916492,     3.7462851217048895e-05],
        [0.0016111074669827113, -4.343724020765925e-05,  0.9999987012221245    ]
      ] }
      let(:s) { 3.318483384770641e-08 }
      subject { e.calc_eo(r_mtx, s) }
      it { expect(subject).to eq -0.003708039788085105 }
    end

    context ".calc_gast" do
      let(:era) { 6.026682507434728     }
      let(:eo)  { -0.003708039788085105 }
      subject { e.calc_gast(era, eo) }
      it { expect(subject).to eq 6.030390547222813 }
    end

    context ".calc_gmst" do
      let(:gast) { 6.026682507434728   }
      let(:t)    { 0.16680355920602327 }
      subject { e.calc_gmst(gast, t) }
      it { expect(subject).to eq 6.030412554087049 }
    end

    context ".calc_ee" do
      let(:gast) { 6.030390547222813 }
      let(:gmst) { 6.030412554087049 }
      subject { e.calc_ee(gast, gmst) }
      it { expect(subject).to be_within(1.0e-21).of(-2.2006864235812884e-05) }
    end

    context ".norm_angle(1)" do
      let(:angle) { 6.030412554087049 }
      subject { e.norm_angle(angle) }
      it { expect(subject).to eq 6.030412554087049 }
    end

    context ".norm_angle(2)" do
      let(:angle) { 8.030412554087049 }
      subject { e.norm_angle(angle) }
      it { expect(subject).to eq 1.7472272469074621 }
    end

    context ".norm_angle(3)" do
      let(:angle) { -6.030412554087049 }
      subject { e.norm_angle(angle) }
      it { expect(subject).to eq 0.252772753092537 }
    end
  end
end

