library ieee;
use ieee.std_logic_1164.all;

entity tb_ffd is
end tb_ffd;

architecture sim of tb_ffd is
    signal clk : std_logic := '0';
    signal rst, ena, d, q : std_logic := '0';
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

    uut: entity work.ffd
        port map (clk => clk, rst => rst, ena => ena, d => d, q => q);

    process
        -- espera un flanco y 1 ns mas para que la salida ya se haya actualizado
        procedure ciclo is
        begin
            wait until rising_edge(clk);
            wait for 1 ns;
        end procedure;
    begin
        -- reset
        rst <= '1'; ena <= '0'; d <= '1';
        ciclo;
        assert q = '0' report "no resetea" severity error;

        -- sin ena no tiene que cargar
        rst <= '0';
        ciclo;
        assert q = '0' report "cargo con ena=0" severity error;

        -- con ena carga d
        ena <= '1';
        ciclo;
        assert q = '1' report "no cargo d=1" severity error;

        d <= '0';
        ciclo;
        assert q = '0' report "no cargo d=0" severity error;

        d <= '1';
        ciclo;
        assert q = '1' report "no cargo d=1 (2)" severity error;

        -- el reset es sincronico: si lo subo entre flancos q no se mueve
        rst <= '1';
        wait for 2 ns;
        assert q = '1' report "el reset actuo sin flanco (no es sincronico)" severity error;
        ciclo;
        assert q = '0' report "el reset no actuo en el flanco" severity error;

        -- el reset gana aunque ena=1 y d=1
        ciclo;
        assert q = '0' report "reset no tiene prioridad" severity error;

        report "tb_ffd terminado";
        fin <= true;
        wait;
    end process;
end sim;
