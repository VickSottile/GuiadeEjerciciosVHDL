library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter is
    generic (
        N : integer := 8;   -- ancho del dato
        M : integer := 3    -- bits de des, tiene que cumplirse 2^M = N
    );
    port (
        a   : in  std_logic_vector(N-1 downto 0);
        des : in  std_logic_vector(M-1 downto 0);
        s   : out std_logic_vector(N-1 downto 0)
    );
end barrel_shifter;

-- desplazamiento logico a la derecha (entran ceros por la izquierda)
architecture comportamiento of barrel_shifter is
begin
    assert 2**M = N report "barrel_shifter: tiene que ser 2^M = N" severity failure;

    s <= std_logic_vector(shift_right(unsigned(a), to_integer(unsigned(des))));
end comportamiento;
