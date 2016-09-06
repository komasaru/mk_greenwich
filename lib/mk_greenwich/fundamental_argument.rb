module MkGreenwich
  #===========================================================================
  # Module for Fundamental arguments
  #===========================================================================
  module FundamentalArgument
    module_function

    #-------------------------------------------------------------------------
    # Mean anomaly of the Moon (IERS 2003)
    #
    # @param:  t  (Julian Centry)
    # @return: l  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_l_iers2003(t)
      return ((    485868.249036  + \
              (1717915923.2178    + \
              (        31.8792    + \
              (         0.051635  + \
              (        -0.00024470) \
              * t) * t) * t) * t) % Const::TURNAS) * Const::AS2R
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # Mean anomaly of the Sun (IERS 2003)
    #
    # @param:  t  (Julian Centry)
    # @return: p  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_p_iers2003(t)
      return ((   1287104.793048  + \
              ( 129596581.0481    + \
              (       - 0.5532    + \
              (         0.000136  + \
              (       - 0.00001149) \
              * t) * t) * t) * t) % Const::TURNAS) * Const::AS2R
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # Mean longitude of the Moon minus that of the ascending node (IERS 2003)
    #
    # @param:  t  (Julian Centry)
    # @return: f  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_f_iers2003(t)
      return ((     335779.526232 + \
              (1739527262.8478    + \
              (       -12.7512    + \
              (        -0.001037  + \
              (         0.00000417) \
              * t) * t) * t) * t) % Const::TURNAS) * Const::AS2R
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # mean elongation of the Moon from the Sun (IERS 2003)
    #
    # @param:  t  (Julian Centry)
    # @return: d  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_d_iers2003(t)
      return ((   1072260.703692  + \
              (1602961601.2090    + \
              (       - 6.3706    + \
              (         0.006593  + \
              (       - 0.00003169) \
              * t) * t) * t) * t) % Const::TURNAS ) * Const::AS2R
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # Mean longitude of the ascending node of the Moon (IERS 2003)
    #
    # @param:  t   (Julian Centry)
    # @return: om  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_om_iers2003(t)
     return ((    450160.398036  + \
             (  -6962890.5431    + \
             (         7.4722    + \
             (         0.007702  + \
             (        -0.00005939) \
             * t) * t) * t) * t) % Const::TURNAS) * Const::AS2R
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # Venus longitudes (IERS 2003)
    #
    # @param:  t   (Julian Centry)
    # @return: ve  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_ve_iers2003(t)
      return (3.176146697 + 1021.3285546211 * t) % Const::PI2
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # Earth longitudes (IERS 2003)
    #
    # @param:  t   (Julian Centry)
    # @return: ea  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_ea_iers2003(t)
      return (1.753470314 + 628.3075849991 * t) % Const::PI2
    rescue => e
      raise
    end

    #-------------------------------------------------------------------------
    # General accumulated precession in longitude (IERS 2003)
    #
    # @param:  t   (Julian Centry)
    # @return: pa  (Unit: rad)
    #-------------------------------------------------------------------------
    def calc_pa_iers2003(t)
      return (0.024381750 + 0.00000538691 * t) * t
    rescue => e
      raise
    end
  end
end

