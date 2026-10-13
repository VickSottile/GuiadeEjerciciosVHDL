library ieee;
use ieee.std_logic_1164.all;

entity gen_ena is
    generic (N : integer := 10);   -- un pulso cada N ciclos de reloj
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        s   : out std_logic
    );
end gen_ena;

architecture comportamiento of gen_ena is
    signal cuenta : integer range 0 to N-1;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cuenta <= 0;
            elsif ena = '1' then
                if cuenta = N-1 then
                    cuenta <= 0;
                else
                    cuenta <= cuenta + 1;
                end if;
            end if;
        end if;
    end process;

    s <= '1' when (cuenta = N-1 and ena = '1') else '0';
end comportamiento;
