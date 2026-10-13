library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- prueba la version por comportamiento (ej 8) y la de muxes (ej 9)
entity tb_barrel_shifter is
end tb_barrel_shifter;

architecture sim of tb_barrel_shifter is
    constant N : integer := 8;
    constant M : integer := 3;

    signal a : std_logic_vector(N-1 downto 0) := (others => '0');
    signal des : std_logic_vector(M-1 downto 0) := (others => '0');
    signal s_comp, s_mux : std_logic_vector(N-1 downto 0);
begin
    uut_comp: entity work.barrel_shifter
        generic map (N => N, M => M)
        port map (a => a, des => des, s => s_comp);

    uut_mux: entity work.barrel_shifter_mux
        generic map (N => N, M => M)
        port map (a => a, des => des, s => s_mux);

    process
    begin
        for x in 0 to 2**N - 1 loop
            for d in 0 to 2**M - 1 loop
                a   <= std_logic_vector(to_unsigned(x, N));
                des <= std_logic_vector(to_unsigned(d, M));
                wait for 10 ns;

                -- correr a la derecha d lugares es dividir por 2^d
                assert to_integer(unsigned(s_comp)) = x / 2**d
                    report "comportamiento mal: x=" & integer'image(x) & " des=" & integer'image(d)
                    severity error;
                assert s_mux = s_comp
                    report "version con muxes distinta: x=" & integer'image(x) & " des=" & integer'image(d)
                    severity error;
            end loop;
        end loop;

        report "tb_barrel_shifter terminado";
        wait;
    end process;
end sim;
