library ieee;
use ieee.std_logic_1164.all;

entity sumador_4bits is
    port (
        ci : in  std_logic;
        a  : in  std_logic_vector(3 downto 0);
        b  : in  std_logic_vector(3 downto 0);
        s  : out std_logic_vector(3 downto 0);
        co : out std_logic
    );
end sumador_4bits;

-- cuatro sumadores de 1 bit encadenados por el carry
architecture estructural of sumador_4bits is
    signal c : std_logic_vector(4 downto 0);
begin
    c(0) <= ci;
    co   <= c(4);

    gen_sum: for i in 0 to 3 generate
        sum_i: entity work.sumador_1bit
            port map (ci => c(i), a => a(i), b => b(i), s => s(i), co => c(i+1));
    end generate;
end estructural;
