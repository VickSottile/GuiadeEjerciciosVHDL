library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    generic (N : integer := 1);   -- ancho de las entradas
    port (
        sel : in  std_logic;
        a0  : in  std_logic_vector(N-1 downto 0);
        a1  : in  std_logic_vector(N-1 downto 0);
        y   : out std_logic_vector(N-1 downto 0)
    );
end mux2x1;

architecture comportamiento of mux2x1 is
begin
    y <= a1 when sel = '1' else a0;
end comportamiento;
