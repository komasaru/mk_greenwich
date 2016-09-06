require "spec_helper"

describe MkGreenwich::Greenwich do
  # 2016-07-23 00:00:00 +00:00 (TDB)
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
        [0.9999918271499867,    -0.0037080294810666083, -0.0016112574588758337 ],
        [0.0037080946537372344,  0.9999931242916492,     3.7462851217048895e-05],
        [0.0016111074669827113, -4.343724020765925e-05,  0.9999987012221245    ]
      ]) }
    end

    context "@s" do
      it { expect(g.instance_variable_get(:@s)).to be_within(1.0e-23).of(3.318483384770641e-08) }
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
      it { expect(g.eo).to eq -0.003708039788085105 }
    end

    context ".gast" do
      it { expect(g.gast).to eq 6.030390547222813 }
    end

    context ".gast_deg" do
      it { expect(g.gast_deg).to eq 345.51592717145417 }
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
      it { expect(g.ee).to be_within(1.0e-21).of(-2.2006864235812884e-05) }
    end

    context ".ee_deg" do
      it { expect(g.ee_deg).to eq -0.001260900441029472 }
    end

    context ".ee_hms" do
      it { expect(g.ee_hms).to eq "-0 h 00 m 00.303 s" }
    end

    context ".calc_jc" do
      subject { g.send(:calc_jc, 2457637.5) }
      it { expect(subject).to eq 0.16680355920602327 }
    end

    context ".prod_mtx" do
      let(:r_1) { [
        [0.9999917301601547,    -0.003730040371107358,  -0.0016206202918558651 ],
        [0.0037300404586375537,  0.9999930433704853,    -2.9684918178563002e-06],
        [0.0016206200903952324, -3.0765119877207425e-06, 0.9999986867896666    ]
      ] }
      let(:r_2) { [
        [ 0.9999999997139412,     2.1945600446413657e-05, 9.513589485750673e-06 ],
        [-2.1945984741774317e-05, 0.9999999989432629,     4.0396137979625824e-05],
        [-9.512702958193633e-06, -4.03963467530688e-05,   0.9999999991388218    ]
      ] }
      subject { g.send(:prod_mtx, r_1, r_2) }
      it { expect(subject).to match([
        [
          be_within(1.0e-16).of( 0.9999918271499867    ),
          be_within(1.0e-19).of(-0.0037080294810666083 ),
          be_within(1.0e-19).of(-0.0016112574588758337 )
        ], [
          be_within(1.0e-19).of( 0.0037080946537372344 ),
          be_within(1.0e-16).of( 0.9999931242916492    ),
          be_within(1.0e-21).of( 3.7462851217048895e-05)
        ], [
          be_within(1.0e-19).of( 0.0016111074669827113 ),
          be_within(1.0e-20).of(-4.343724020765925e-05 ),
          be_within(1.0e-16).of( 0.9999987012221245    )
        ]
      ]) }
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

