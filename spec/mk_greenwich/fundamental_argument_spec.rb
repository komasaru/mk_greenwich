require "spec_helper"

describe MkGreenwich::FundamentalArgument do
  let(:f) { MkGreenwich::FundamentalArgument }
  let(:t) { 0.16680355920602327 }

  context ".calc_l_iers2003" do
    subject { f.calc_l_iers2003(t) }
    it { expect(subject).to be_within(1.0e-16).of(3.0269804968401375) }
  end

  context ".calc_p_iers2003" do
    subject { f.calc_p_iers2003(t) }
    it { expect(subject).to be_within(1.0e-15).of(4.228912208933477) }
  end

  context ".calc_f_iers2003" do
    subject { f.calc_f_iers2003(t) }
    it { expect(subject).to be_within(1.0e-16).of(0.9265659704485146) }
  end

  context ".calc_d_iers2003" do
    subject { f.calc_d_iers2003(t) }
    it { expect(subject).to be_within(1.0e-16).of(0.8724749606696042) }
  end

  context ".calc_om_iers2003" do
    subject { f.calc_om_iers2003(t) }
    it { expect(subject).to be_within(1.0e-15).of(2.834830098559794) }
  end

  context ".calc_ve_iers2003" do
    subject { f.calc_ve_iers2003(t) }
    it { expect(subject).to be_within(1.0e-15).of(3.891381432693997) }
  end

  context ".calc_ea_iers2003" do
    subject { f.calc_ea_iers2003(t) }
    it { expect(subject).to be_within(1.0e-15).of(6.026446853117491) }
  end

  context ".calc_pa_iers2003" do
    subject { f.calc_pa_iers2003(t) }
    it { expect(subject).to be_within(1.0e-18).of(0.004067112561970559) }
  end
end

