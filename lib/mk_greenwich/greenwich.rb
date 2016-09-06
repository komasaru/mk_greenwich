module MkGreenwich
  class Greenwich
    attr_reader :utc, :tt, :ut1, :tdb

    def initialize(utc)
      @utc = utc                                              # 協定世界時
      t_utc = MkTime.new(@utc.strftime("%Y%m%d%H%M%S"))
      @tt  = t_utc.tt                                         # 地球時(for UTC)
      @ut1 = t_utc.ut1                                        # 世界時1(for TT)
      @tdb = t_utc.tdb                                        # 太陽系力学時(for TT)
      @jd  = t_utc.jd                                         # ユリウス日(for TT)
      @jc = calc_jc(@jd)                                      # ユリウス世紀数(for TT)
      @jd_ut1 = MkTime.new(@ut1.strftime("%Y%m%d%H%M%S")).jd  # ユリウス日(for UT1)
      @t = @jd_ut1 - Const::J2000
      bpn = EphBpn.new(@tdb.strftime("%Y%m%d%H%M%S"))
      @r_mtx = prod_mtx(bpn.r_bias_prec, bpn.r_nut)
      cc = CipCio.new(@jc)
      x, y = cc.bpn2xy(@r_mtx)
      @s = cc.calc_s_06(x, y)
      @e = EraEors.new(@jd_ut1)
    end

    #=========================================================================
    # Earth rotation angle
    #
    # * IAU 2000 model
    #
    # @param:  <none>
    # @return: @era
    #=========================================================================
    def era
      @era = @e.calc_era(@jd, @t)
      return @era
    end

    #=========================================================================
    # Equation of the origins, given the classical NPB matrix and the
    # quantity s.
    #
    # @param:  <none>
    # @return: @eo
    #=========================================================================
    def eo
      @eo = @e.calc_eo(@r_mtx, @s)
      return @eo
    end

    #=========================================================================
    # Greenwich apparent sidereal time (Unit: rad)
    #
    # @param:  <none>
    # @return: @gast
    #=========================================================================
    def gast
      @era  = @e.calc_era(@jd, @t)   unless @era
      @eo   = @e.calc_eo(@r_mtx, @s) unless @eo
      @gast = @e.calc_gast(@era, @eo)
      return @gast
    end

    #=========================================================================
    # Greenwich apparent sidereal time (Unit: deg)
    #
    # @param:  <none>
    # @return: @gast_deg
    #=========================================================================
    def gast_deg
      @gast = gast unless @gast
      @gast_deg = @gast / Const::PI_180
      return @gast_deg
    end

    #=========================================================================
    # Greenwich apparent sidereal time (Unit: HMS)
    #
    # @param:  <none>
    # @return: @gast_hms
    #=========================================================================
    def gast_hms
      @gast_deg = gast_deg unless @gast_deg
      @gast_hms = deg2hms(@gast_deg)
      return @gast_hms
    end

    #=========================================================================
    # Greenwich mean sidereal time, IAU 2006. (Unit: rad)
    #
    # @param:  <none>
    # @return: @gmst
    #=========================================================================
    def gmst
      @era  = @e.calc_era(@jd, @t)   unless @era
      @gmst = @e.calc_gmst(@era, @jc)
      return @gmst
    end

    #=========================================================================
    # Greenwich mean sidereal time, IAU 2006. (Unit: deg)
    #
    # @param:  <none>
    # @return: @gmst_geg
    #=========================================================================
    def gmst_deg
      @gmst = gmst unless @gast
      @gmst_deg = @gmst / Const::PI_180
      return @gmst_deg
    end

    #=========================================================================
    # Greenwich mean sidereal time, IAU 2006. (Unit: HMS)
    #
    # @param:  <none>
    # @return: @gmst_hms
    #=========================================================================
    def gmst_hms
      @gmst_deg = gmst_deg unless @gmst_deg
      @gmst_hms = deg2hms(@gmst_deg)
      return @gmst_hms
    end

    #=========================================================================
    # Equation of Equinoxes (Unit: rad)
    #
    # @param:  <none>
    # @return: @ee
    #=========================================================================
    def ee
      @gast = gast unless @gast
      @gmst = gmst unless @gmst
      @ee = @e.calc_ee(@gast, @gmst)
      return @ee
    end

    #=========================================================================
    # Equation of Equinoxes (Unit: deg)
    #
    # @param:  <none>
    # @return: @ee_deg
    #=========================================================================
    def ee_deg
      @ee = ee unless @ee
      @ee_deg = @ee / Const::PI_180
      return @ee_deg
    end

    #=========================================================================
    # Equation of Equinoxes (Unit: HMS)
    #
    # @param:  <none>
    # @return: @ee_hms
    #=========================================================================
    def ee_hms
      @ee_deg = ee_deg unless @ee_deg
      @ee_hms = deg2hms(@ee_deg)
      return @ee_hms
    end

    private

    #-------------------------------------------------------------------------
    # ユリウス世紀数の計算
    #
    # @param:  jd  (Julian Day)
    # @return: jc  (Julian Centry)
    #-------------------------------------------------------------------------
    def calc_jc(jd)
      return (jd - Const::J2000) / Const::JC
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # 行列の積 (3x3)
    #
    # @param:  r_1  (3x3-matrix)
    # @param:  r_2  (3x3-matrix)
    # @return: r    (3x3-matrix)
    #-------------------------------------------------------------------------
    def prod_mtx(r_1, r_2)
      r = Array.new(3).map { |a| Array.new(3, 0.0) }

      begin
        0.upto(2) do |i|
          0.upto(2) do |j|
            r[i][j] = (0..2).inject(0.0) { |s, k| s + r_1[i][k] * r_2[k][j] }
          end
        end
        return r
      rescue => e
        raise
      end
    end

    def deg2hms(deg)
      sign = ""

      begin
        h = (deg / 15.0).truncate
        _m = (deg - h * 15.0) * 4.0
        m = _m.truncate
        s = (_m - m) * 60.0
        if s < 0
          s *= -1
          sign = "-"
        end
        return sprintf("%s%d h %02d m %06.3f s", sign, h, m, s)
      rescue => e
        raise
      end
    end
  end
end

