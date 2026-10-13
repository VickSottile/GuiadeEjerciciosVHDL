library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sumador_1bit is
end tb_sumador_1bit;

architecture sim of tb_sumador_1bit is
    signal ci, a, b, s, co : std_logic := '0';
begin
    uut: entity work.sumador_1bit
        port map (ci => ci, a => a, b => b, s => s, co => co);

    process
        variable v     : std_logic_vector(2 downto 0);
        variable suma  : integer;
    begin
        for i in 0 to 7 loop
            v  := std_logic_vector(to_unsigned(i, 3));
            ci <= v(2);
            a  <= v(1);
            b  <= v(0);
            wait for 10 ns;

            suma := (i / 4) + ((i / 2) mod 2) + (i mod 2);
            assert (s = '1')  = (suma mod 2 = 1) report "s mal con i=" & integer'image(i) severity error;
            assert (co = '1') = (suma >= 2)      report "co mal con i=" & integer'image(i) severity error;
        end loop;
        report "tb_sumador_1bit terminado";
        wait;
    end process;
end sim;
