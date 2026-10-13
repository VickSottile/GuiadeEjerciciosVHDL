library ieee;
use ieee.std_logic_1164.all;

entity tb_gen_ena is
end tb_gen_ena;

architecture sim of tb_gen_ena is
    constant N : integer := 5;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ena : std_logic := '1';
    signal s : std_logic;
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

    uut: entity work.gen_ena
        generic map (N => N)
        port map (clk => clk, rst => rst, ena => ena, s => s);

    process
        procedure esperar(ciclos : integer) is
        begin
            for i in 1 to ciclos loop
                wait until falling_edge(clk);
            end loop;
        end procedure;
    begin
        rst <= '1'; ena <= '1'; esperar(2);
        rst <= '0';

        -- despues de soltar el reset, el pulso tiene que aparecer cada N ciclos
        -- (en j = N-1, 2N-1, 3N-1...) y durar un solo ciclo
        for j in 1 to 4*N loop
            wait until falling_edge(clk);
            assert (s = '1') = (j mod N = N-1)
                report "pulso mal en el ciclo " & integer'image(j) severity error;
        end loop;

        -- con ena=0 no tiene que salir nada
        ena <= '0';
        for j in 1 to 3*N loop
            wait until falling_edge(clk);
            assert s = '0' report "salio pulso con ena=0" severity error;
        end loop;

        report "tb_gen_ena terminado";
        fin <= true;
        wait;
    end process;
end sim;
