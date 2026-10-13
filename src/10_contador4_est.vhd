library ieee;
use ieee.std_logic_1164.all;

entity contador4_est is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end contador4_est;

-- cada ffd togglea (xor) cuando ena y todos los bits de abajo estan en 1
architecture estructural of contador4_est is
    signal qi : std_logic_vector(3 downto 0);
    signal d  : std_logic_vector(3 downto 0);
    signal t  : std_logic_vector(3 downto 0);
begin
    t(0) <= ena;
    t(1) <= t(0) and qi(0);
    t(2) <= t(1) and qi(1);
    t(3) <= t(2) and qi(2);

    d <= qi xor t;

    gen_ff: for i in 0 to 3 generate
        ff_i: entity work.ffd
            port map (clk => clk, rst => rst, ena => '1', d => d(i), q => qi(i));
    end generate;

    q <= qi;
end estructural;
