library ieee;
use ieee.std_logic_1164.all;

-- prueba el registro estructural (ej 6) y el de comportamiento (ej 7) con la misma entrada
entity tb_registro_desp is
end tb_registro_desp;

architecture sim of tb_registro_desp is
    signal clk : std_logic := '0';
    signal e, s_est, s_comp : std_logic := '0';
    signal fin : boolean := false;
begin
    reloj: process
    begin
        while not fin loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;

    uut_est: entity work.registro_desp_est
        port map (clk => clk, e => e, s => s_est);

    uut_comp: entity work.registro_desp_comp
        port map (clk => clk, e => e, s => s_comp);

    process
        constant patron : std_logic_vector(0 to 19) := "10110011100010110100";
        -- hist(0) es lo ultimo que entro, hist(3) lo que entro hace 3 flancos
        variable hist : std_logic_vector(3 downto 0) := "0000";
    begin
        for i in 0 to 19 loop
            e <= patron(i);
            wait until rising_edge(clk);
            hist := hist(2 downto 0) & patron(i);
            wait for 1 ns;

            -- el bit tarda 4 flancos en recorrer los 4 ff, antes la salida no es valida
            if i >= 3 then
                assert s_est = hist(3)
                    report "estructural: mal en el ciclo " & integer'image(i) severity error;
                assert s_comp = hist(3)
                    report "comportamiento: mal en el ciclo " & integer'image(i) severity error;
            end if;
        end loop;

        report "tb_registro_desp terminado";
        fin <= true;
        wait;
    end process;
end sim;
