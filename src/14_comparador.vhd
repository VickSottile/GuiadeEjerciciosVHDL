library ieee;
use ieee.std_logic_1164.all;

entity comparador is
    generic (N : integer := 4);
    port (
        a     : in  std_logic_vector(N-1 downto 0);
        b     : in  std_logic_vector(N-1 downto 0);
        igual : out std_logic
    );
end comparador;

architecture comportamiento of comparador is
begin
    igual <= '1' when a = b else '0';
end comportamiento;
