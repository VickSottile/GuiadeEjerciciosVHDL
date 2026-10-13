library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_contador_bcd4 is
end tb_contador_bcd4;

architecture sim of tb_contador_bcd4 is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ena : std_logic := '0';
    signal bcd3, bcd2, bcd1, bcd0 : std_logic_vector(3 downto 0);
    signal co : std_logic;
    signal modelo : integer := 0;
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

    uut: entity work.contador_bcd4
        port map (clk => clk, rst => rst, ena => ena,
                  bcd3 => bcd3, bcd2 => bcd2, bcd1 => bcd1, bcd0 => bcd0, co => co);

    cuenta_modelo: process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                modelo <= 0;
            elsif ena = '1' then
                modelo <= (modelo + 1) mod 10000;
            end if;
        end if;
    end process;

    chequeo: process (clk)
    begin
        if falling_edge(clk) then
            assert to_integer(unsigned(bcd0)) = modelo mod 10
                report "bcd0 mal, modelo=" & integer'image(modelo) severity error;
            assert to_integer(unsigned(bcd1)) = (modelo / 10) mod 10
                report "bcd1 mal, modelo=" & integer'image(modelo) severity error;
            assert to_integer(unsigned(bcd2)) = (modelo / 100) mod 10
                report "bcd2 mal, modelo=" & integer'image(modelo) severity error;
            assert to_integer(unsigned(bcd3)) = (modelo / 1000) mod 10
                report "bcd3 mal, modelo=" & integer'image(modelo) severity error;
            assert (co = '1') = (modelo = 9999 and ena = '1')
                report "co mal, modelo=" & integer'image(modelo) severity error;
        end if;
    end process;

    estimulo: process
        procedure esperar(ciclos : integer) is
        begin
            for i in 1 to ciclos loop
                wait until falling_edge(clk);
            end loop;
        end procedure;
    begin
        rst <= '1'; ena <= '0'; esperar(2);
        rst <= '0'; ena <= '1'; esperar(10050);   -- llega a 9999 y da la vuelta
        ena <= '0'; esperar(5);
        ena <= '1'; esperar(120);
        rst <= '1'; esperar(2);
        rst <= '0'; esperar(5);

        report "tb_contador_bcd4 terminado";
        fin <= true;
        wait;
    end process;
end sim;
