library ieee;
use ieee.std_logic_1164.all;

entity incrementador4 is
    port (
        a : in  std_logic_vector(3 downto 0);
        y : out std_logic_vector(3 downto 0)
    );
end incrementador4;

-- reuso el sumador de 4 bits: a + 0 con carry de entrada en 1
architecture estructural of incrementador4 is
    constant ceros : std_logic_vector(3 downto 0) := "0000";
begin
    sumador: entity work.sumador_4bits
        port map (ci => '1', a => a, b => ceros, s => y, co => open);
end estructural;
