require "mk_greenwich/fundamental_argument"

module MkGreenwich
  class CipCio
    include MkGreenwich::FundamentalArgument

    #-------------------------------------------------------------------------
    # Initialization
    #
    # @param:  t  (Julian Century)
    #-------------------------------------------------------------------------
    def initialize(t)
      @t = t
    end

    #-------------------------------------------------------------------------
    # Extract from the bias-precession-nutation matrix the X,Y coordinates
    # of the Celestial Intermediate Pole.
    #
    # @param:  r       (Rotation Matrix)
    # @return: [x, y]  (x, y cordinates of CIP)
    #-------------------------------------------------------------------------
    def bpn2xy(r)
      return [r[2][0], r[2][1]]
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # The CIO locator s, positioning the Celestial Intermediate Origin on
    # the equator of the Celestial Intermediate Pole, given the CIP's X,Y
    # coordinates.  Compatible with IAU 2006/2000A precession-nutation.
    #
    # @param:  x  (x coordinate of CIP)
    # @param:  y  (y coordinate of CIP)
    # @return: s  (CIO locator (Unit: rad))
    #-------------------------------------------------------------------------
    def calc_s_06(x, y)
      # Fundamental Arguments (from IERS Conventions 2003)
      fa = [
        # Mean anomaly of the Moon.(Ref: iauFal03(t))
        calc_l_iers2003(@t),
        # Mean anomaly of the Sun.(Ref: iauFalp03(t))
        calc_p_iers2003(@t),
        # Mean longitude of the Moon minus that of the ascending node.(Ref: iauFaf03(t))
        calc_f_iers2003(@t),
        # Mean elongation of the Moon from the Sun.(Ref: iauFad03(t))
        calc_d_iers2003(@t),
        # Mean longitude of the ascending node of the Moon.(Ref: iauFaom03(t))
        calc_om_iers2003(@t),
        # Mean longitude of Venus.(Ref: iauFave03(t))
        calc_ve_iers2003(@t),
        # Mean longitude of Earth.(Ref: iauFae03(t))
        calc_ea_iers2003(@t),
        # General precession in longitude.(Ref: iauFapa03(t))
        calc_pa_iers2003(@t)
      ]
      # Evaluate s.
      w_0, w_1, w_2, w_3, w_4, w_5 = Const::SP
      (Const::S_0.size - 1).downto(0) do |i|
        a = 0.0
        0.upto(7) { |j| a += Const::S_0[i][0][j] * fa[j] }
        w_0 += Const::S_0[i][1] * Math.sin(a) + Const::S_0[i][2] * Math.cos(a)
      end
      (Const::S_1.size - 1).downto(0) do |i|
        a = 0.0
        0.upto(7) { |j| a += Const::S_1[i][0][j] * fa[j] }
        w_1 += Const::S_1[i][1] * Math.sin(a) + Const::S_1[i][2] * Math.cos(a)
      end
      (Const::S_2.size - 1).downto(0) do |i|
        a = 0.0
        0.upto(7) { |j| a += Const::S_2[i][0][j] * fa[j] }
        w_2 += Const::S_2[i][1] * Math.sin(a) + Const::S_2[i][2] * Math.cos(a)
      end
      (Const::S_3.size - 1).downto(0) do |i|
        a = 0.0
        0.upto(7) { |j| a += Const::S_3[i][0][j] * fa[j] }
        w_3 += Const::S_3[i][1] * Math.sin(a) + Const::S_3[i][2] * Math.cos(a)
      end
      (Const::S_4.size - 1).downto(0) do |i|
        a = 0.0
        0.upto(7) { |j| a += Const::S_4[i][0][j] * fa[j] }
        w_4 += Const::S_4[i][1] * Math.sin(a) + Const::S_4[i][2] * Math.cos(a)
      end
      return (w_0 + (w_1 + (w_2 + (w_3 + (w_4 + w_5 \
             * @t) * @t) * @t) * @t) * @t) * Const::AS2R - x * y / 2.0
    rescue => e
      raise
    end
  end
end

