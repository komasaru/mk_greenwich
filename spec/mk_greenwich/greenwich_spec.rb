require "spec_helper"

describe MkGreenwich::Greenwich do
  # 2016-09-06 00:00:00 +00:00 (TDB)
  let(:g) { MkGreenwich::Greenwich.new(Time.new(2016, 9, 6, 0, 0, 0, "+00:00")) }

  context ".new(2016-09-06 00:00:00 +0000)" do
    context "object" do
      it { expect(g).to be_an_instance_of(MkGreenwich::Greenwich) }
    end

    context "@utc" do
      it { expect(g.instance_variable_get(:@utc).strftime("%Y-%m-%d %H:%M:%S")).to eq "2016-09-06 00:00:00" }
    end

    context "@tt" do
      it { expect(g.instance_variable_get(:@tt).strftime("%Y-%m-%d %H:%M:%S")).to eq "2016-09-06 00:01:08" }
    end

    context "@ut1" do
      it { expect(g.instance_variable_get(:@ut1).strftime("%Y-%m-%d %H:%M:%S")).to eq "2016-09-05 23:59:59" }
    end

    context "@tdb" do
      it { expect(g.instance_variable_get(:@tdb).strftime("%Y-%m-%d %H:%M:%S")).to eq "2016-09-06 00:01:08" }
    end

    context "@jd" do
      it { expect(g.instance_variable_get(:@jd)).to eq 2457637.5 }
    end

    context "@jc" do
      it { expect(g.instance_variable_get(:@jc)).to eq 0.16680355920602327 }
    end

    context "@jd_ut1" do
      it { expect(g.instance_variable_get(:@jd_ut1)).to eq 2457637.499988426 }
    end

    context "@t" do
      it { expect(g.instance_variable_get(:@t)).to eq 6092.499988425989 }
    end

    context "@r_mtx" do
      it { expect(g.instance_variable_get(:@r_mtx)).to match([
        [0.9999918271499899,    -0.0037080949515300174, -0.0016111067795452011 ],
        [0.0037081601182366707,  0.9999931240488853,     3.7463159224315756e-05],
        [0.0016109567847021563, -4.343709494969428e-05,  0.9999987014648851    ]
      ]) }
    end

    context "@s" do
      it { expect(g.instance_variable_get(:@s)).to eq 3.3181444234346554e-08 }
    end

    context "@e" do
      let(:e) { g.instance_variable_get(:@e) }
      it do
        expect(e).to be_an_instance_of(MkGreenwich::EraEors)
        expect(e.instance_variable_get(:@jd)).to eq 2457637.499988426
        expect(e.instance_variable_get(:@t)).to eq 6092.499988425989
      end
    end

    context ".era" do
      it { expect(g.era).to eq 6.026682507434728 }
    end

    context ".eo" do
      it { expect(g.eo).to eq -0.0037081052589986517 }
    end

    context ".gast" do
      it { expect(g.gast).to eq 6.030390612693727 }
    end

    context ".gast_deg" do
      it { expect(g.gast_deg).to eq 345.51593092266114 }
    end

    context ".gast_hms" do
      it { expect(g.gast_hms).to eq "23 h 02 m 03.823 s" }
    end

    context ".gmst" do
      it { expect(g.gmst).to eq 6.030412554087049 }
    end

    context ".gmst_deg" do
      it { expect(g.gmst_deg).to eq 345.5171880718952 }
    end

    context ".gmst_hms" do
      it { expect(g.gmst_hms).to eq "23 h 02 m 04.125 s" }
    end

    context ".ee" do
      it { expect(g.ee).to eq -2.1941393322677527e-05 }
    end

    context ".ee_deg" do
      it { expect(g.ee_deg).to eq -0.0012571492340259483 }
    end

    context ".ee_hms" do
      it { expect(g.ee_hms).to eq "-0 h 00 m 00.302 s" }
    end

    context ".calc_jc" do
      subject { g.send(:calc_jc, 2457637.5) }
      it { expect(subject).to eq 0.16680355920602327 }
    end

    context ".deg2hms(1)" do
      subject { g.send(:deg2hms, 345.51592717145417) }
      it { expect(subject).to eq "23 h 02 m 03.823 s" }
    end

    context ".deg2hms(2)" do
      subject { g.send(:deg2hms, -0.001260900441029472) }
      it { expect(subject).to eq "-0 h 00 m 00.303 s" }
    end
  end
end

