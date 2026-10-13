library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sumador_4bits is
end tb_sumador_4bits;

architecture sim of tb_sumador_4bits is
    signal ci, co : std_logic := '0';
    signal a, b, s : std_logic_vector(3 downto 0) := (others => '0');
begin
    uut: entity work.sumador_4bits
        port map (ci => ci, a => a, b => b, s => s, co => co);

    process
        variable esperado : integer;
    begin
        for c in 0 to 1 loop
            for x in 0 to 15 loop
                for y in 0 to 15 loop
                    if c = 1 then ci <= '1'; else ci <= '0'; end if;
                    a <= std_logic_vector(to_unsigned(x, 4));
                    b <= std_logic_vector(to_unsigned(y, 4));
                    wait for 10 ns;

                    esperado := x + y + c;
                    assert to_integer(unsigned(co & s)) = esperado
                        report "falla: " & integer'image(x) & " + " & integer'image(y) & " + " & integer'image(c)
                        severity error;
                end loop;
            end loop;
        end loop;
        report "tb_sumador_4bits terminado";
        wait;
    end process;
end sim;
