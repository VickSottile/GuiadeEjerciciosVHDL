library ieee;
use ieee.std_logic_1164.all;

entity sumador_1bit is
    port (
        ci : in  std_logic;
        a  : in  std_logic;
        b  : in  std_logic;
        s  : out std_logic;
        co : out std_logic
    );
end sumador_1bit;

architecture comportamiento of sumador_1bit is
begin
    s  <= a xor b xor ci;
    co <= (a and b) or (ci and (a xor b));
end comportamiento;
