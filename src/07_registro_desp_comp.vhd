library ieee;
use ieee.std_logic_1164.all;

entity registro_desp_comp is
    port (
        clk : in  std_logic;
        e   : in  std_logic;
        s   : out std_logic
    );
end registro_desp_comp;

architecture comportamiento of registro_desp_comp is
    signal q : std_logic_vector(3 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) then
            q <= e & q(3 downto 1);
        end if;
    end process;

    s <= q(0);
end comportamiento;
