library ieee;
use ieee.std_logic_1164.all;

entity registro_desp_est is
    port (
        clk : in  std_logic;
        e   : in  std_logic;
        s   : out std_logic
    );
end registro_desp_est;

-- 4 ffd en cadena, el dato entra por el bit 3 y sale por el 0
architecture estructural of registro_desp_est is
    signal d : std_logic_vector(3 downto 0);
    signal q : std_logic_vector(3 downto 0);
begin
    d(3)          <= e;
    d(2 downto 0) <= q(3 downto 1);

    gen_ff: for i in 0 to 3 generate
        ff_i: entity work.ffd
            port map (clk => clk, rst => '0', ena => '1', d => d(i), q => q(i));
    end generate;

    s <= q(0);
end estructural;
