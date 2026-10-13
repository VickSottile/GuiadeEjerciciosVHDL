library ieee;
use ieee.std_logic_1164.all;

entity sumrest_4bits is
    port (
        sr : in  std_logic;   -- 0 suma, 1 resta
        a  : in  std_logic_vector(3 downto 0);
        b  : in  std_logic_vector(3 downto 0);
        s  : out std_logic_vector(3 downto 0);
        co : out std_logic
    );
end sumrest_4bits;

-- a - b = a + (not b) + 1, asi que si sr=1 invierto b con xors y uso sr como carry de entrada
architecture estructural of sumrest_4bits is
    signal b_x : std_logic_vector(3 downto 0);
begin
    b_x <= b xor (sr & sr & sr & sr);

    sumador: entity work.sumador_4bits
        port map (ci => sr, a => a, b => b_x, s => s, co => co);
end estructural;
