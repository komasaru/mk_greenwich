require "spec_helper"

describe MkGreenwich::Const do
  context "MSG_ERR_1" do
    it { expect(MkGreenwich::Const::MSG_ERR_1).to eq "[ERROR] Format: YYYYMMDD or YYYYMMDDHHMMSS" }
  end

  context "MSG_ERR_2" do
    it { expect(MkGreenwich::Const::MSG_ERR_2).to eq "[ERROR] Invalid date-time!" }
  end

  context "J2000" do
    it { expect(MkGreenwich::Const::J2000).to eq 2451545.0 }
  end

  context "JC" do
    it { expect(MkGreenwich::Const::JC).to eq 36525.0 }
  end

  context "SP" do
    it { expect(MkGreenwich::Const::SP).to match([
      94.00e-6, 3808.65e-6, -122.68e-6, -72574.11e-6, 27.98e-6, 15.62e-6
    ]) }
  end

  context "S_0" do
    it { expect(MkGreenwich::Const::S_0[0]).to match([
      [0,  0,  0,  0,  1,  0,  0,  0], -2640.73e-6,  0.39e-6
    ]) }
    it { expect(MkGreenwich::Const::S_0[-1]).to match([
      [1,  0, -2,  0, -1,  0,  0,  0],    -0.11e-6,  0.00e-6
    ]) }
  end

  context "S_1" do
    it { expect(MkGreenwich::Const::S_1[0]).to match([
      [0,  0,  0,  0,  2,  0,  0,  0], -0.07e-6,  3.57e-6
    ]) }
    it { expect(MkGreenwich::Const::S_1[-1]).to match([
      [0,  0,  2, -2,  3,  0,  0,  0],  0.00e-6,  0.48e-6
    ]) }
  end

  context "S_2" do
    it { expect(MkGreenwich::Const::S_2[0]).to match([
      [0,  0,  0,  0,  1,  0,  0,  0], 743.52e-6, -0.17e-6
    ]) }
    it { expect(MkGreenwich::Const::S_2[-1]).to match([
      [0,  0,  2,  0,  0,  0,  0,  0],  -0.11e-6,  0.00e-6
    ]) }
  end

  context "S_3" do
    it { expect(MkGreenwich::Const::S_3[0]).to match([
      [0,  0,  0,  0,  1,  0,  0,  0],  0.30e-6, -23.42e-6
    ]) }
    it { expect(MkGreenwich::Const::S_3[-1]).to match([
      [0,  0,  0,  0,  2,  0,  0,  0],  0.00e-6,   0.23e-6
    ]) }
  end

  context "S_4" do
    it { expect(MkGreenwich::Const::S_4).to match([
      [[0,  0,  0,  0,  1,  0,  0,  0], -0.26e-6, -0.01e-6]
    ]) }
  end

  context "AS2R" do
    it { expect(MkGreenwich::Const::AS2R).to be_within(1.0e-30).of(4.848136811095359935899141e-6) }
  end

  context "PI" do
    it { expect(MkGreenwich::Const::PI).to eq 3.141592653589793238462643 }
  end

  context "PI2" do
    it { expect(MkGreenwich::Const::PI2).to eq 6.283185307179586476925287 }
  end

  context "PI_180" do
    it { expect(MkGreenwich::Const::PI_180).to eq 0.017453292519943295 }
  end

  context "TURNAS" do
    it { expect(MkGreenwich::Const::TURNAS).to eq 1296000.0 }
  end
end

