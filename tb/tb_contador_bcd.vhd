library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ej 14 (estructural) y ej 15 (comportamiento)
entity tb_contador_bcd is
end tb_contador_bcd;

architecture sim of tb_contador_bcd is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ena : std_logic := '0';
    signal q_est, q_comp : std_logic_vector(3 downto 0);
    signal co_est, co_comp : std_logic;
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

    uut_est: entity work.contador_bcd_est
        port map (clk => clk, rst => rst, ena => ena, q => q_est, co => co_est);

    uut_comp: entity work.contador_bcd_comp
        port map (clk => clk, rst => rst, ena => ena, q => q_comp, co => co_comp);

    cuenta_modelo: process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                modelo <= 0;
            elsif ena = '1' then
                modelo <= (modelo + 1) mod 10;
            end if;
        end if;
    end process;

    chequeo: process (clk)
    begin
        if falling_edge(clk) then
            assert to_integer(unsigned(q_est)) = modelo
                report "estructural: q=" & integer'image(to_integer(unsigned(q_est))) &
                       " esperado=" & integer'image(modelo) severity error;
            assert to_integer(unsigned(q_comp)) = modelo
                report "comportamiento: q=" & integer'image(to_integer(unsigned(q_comp))) &
                       " esperado=" & integer'image(modelo) severity error;
            assert (co_est = '1') = (modelo = 9)  report "co estructural mal" severity error;
            assert (co_comp = '1') = (modelo = 9) report "co comportamiento mal" severity error;
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
        rst <= '0'; ena <= '1'; esperar(35);   -- mas de 3 vueltas
        ena <= '0'; esperar(5);
        ena <= '1'; esperar(4);
        ena <= '0'; esperar(3);                -- pausa en medio de la cuenta
        ena <= '1'; esperar(8);
        rst <= '1'; esperar(2);
        rst <= '0'; esperar(5);

        report "tb_contador_bcd terminado";
        fin <= true;
        wait;
    end process;
end sim;
