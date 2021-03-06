library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        ADD             : integer := 0;
        SUB             : integer := 1;
        \AND\           : integer := 4;
        \OR\            : integer := 5;
        \XOR\           : integer := 6;
        MVHI            : integer := 11;
        \NAND\          : integer := 12;
        \NOR\           : integer := 13;
        \XNOR\          : integer := 14;
        F               : integer := 0;
        EQ              : integer := 1;
        LT              : integer := 2;
        LTE             : integer := 3;
        EQZ             : integer := 5;
        LTZ             : integer := 6;
        LTEZ            : integer := 7;
        T               : integer := 8;
        NE              : integer := 9;
        GTE             : integer := 10;
        GT              : integer := 11;
        NEZ             : integer := 13;
        GTEZ            : integer := 14;
        GTZ             : integer := 15
    );
    port(
        clk             : in     vl_logic;
        opsel           : in     vl_logic_vector(5 downto 0);
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of SUB : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of \XOR\ : constant is 1;
    attribute mti_svvh_generic_type of MVHI : constant is 1;
    attribute mti_svvh_generic_type of \NAND\ : constant is 1;
    attribute mti_svvh_generic_type of \NOR\ : constant is 1;
    attribute mti_svvh_generic_type of \XNOR\ : constant is 1;
    attribute mti_svvh_generic_type of F : constant is 1;
    attribute mti_svvh_generic_type of EQ : constant is 1;
    attribute mti_svvh_generic_type of LT : constant is 1;
    attribute mti_svvh_generic_type of LTE : constant is 1;
    attribute mti_svvh_generic_type of EQZ : constant is 1;
    attribute mti_svvh_generic_type of LTZ : constant is 1;
    attribute mti_svvh_generic_type of LTEZ : constant is 1;
    attribute mti_svvh_generic_type of T : constant is 1;
    attribute mti_svvh_generic_type of NE : constant is 1;
    attribute mti_svvh_generic_type of GTE : constant is 1;
    attribute mti_svvh_generic_type of GT : constant is 1;
    attribute mti_svvh_generic_type of NEZ : constant is 1;
    attribute mti_svvh_generic_type of GTEZ : constant is 1;
    attribute mti_svvh_generic_type of GTZ : constant is 1;
end ALU;
