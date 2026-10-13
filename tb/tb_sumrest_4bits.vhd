library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sumrest_4bits is
end tb_sumrest_4bits;

architecture sim of tb_sumrest_4bits is
    signal sr, co : std_logic := '0';
    signal a, b, s : std_logic_vector(3 downto 0) := (others => '0');
begin
    uut: entity work.sumrest_4bits
        port map (sr => sr, a => a, b => b, s => s, co => co);

    process
    begin
        for op in 0 to 1 loop
            for x in 0 to 15 loop
                for y in 0 to 15 loop
                    if op = 1 then sr <= '1'; else sr <= '0'; end if;
                    a <= std_logic_vector(to_unsigned(x, 4));
                    b <= std_logic_vector(to_unsigned(y, 4));
                    wait for 10 ns;

                    if op = 0 then
                        assert to_integer(unsigned(s)) = (x + y) mod 16
                            report "suma mal: " & integer'image(x) & "+" & integer'image(y) severity error;
                        assert (co = '1') = (x + y >= 16)
                            report "carry de suma mal: " & integer'image(x) & "+" & integer'image(y) severity error;
                    else
                        assert to_integer(unsigned(s)) = (x - y + 16) mod 16
                            report "resta mal: " & integer'image(x) & "-" & integer'image(y) severity error;
                        -- en la resta co=1 significa que no hubo "pedido" (a >= b)
                        assert (co = '1') = (x >= y)
                            report "carry de resta mal: " & integer'image(x) & "-" & integer'image(y) severity error;
                    end if;
                end loop;
            end loop;
        end loop;
        report "tb_sumrest_4bits terminado";
        wait;
    end process;
end sim;
