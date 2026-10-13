library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador4_comp is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end contador4_comp;

architecture comportamiento of contador4_comp is
    signal cuenta : unsigned(3 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cuenta <= (others => '0');
            elsif ena = '1' then
                cuenta <= cuenta + 1;
            end if;
        end if;
    end process;

    q <= std_logic_vector(cuenta);
end comportamiento;
