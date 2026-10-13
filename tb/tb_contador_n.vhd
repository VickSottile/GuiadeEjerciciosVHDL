library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ej 12 y 13. Pruebo con N=5 para ver que no depende de que sea 4
entity tb_contador_n is
end tb_contador_n;

architecture sim of tb_contador_n is
    constant N : integer := 5;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ena : std_logic := '0';
    signal q_est, q_comp : std_logic_vector(N-1 downto 0);
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

    uut_est: entity work.contador_n_est
        generic map (N => N)
        port map (clk => clk, rst => rst, ena => ena, q => q_est);

    uut_comp: entity work.contador_n_comp
        generic map (N => N)
        port map (clk => clk, rst => rst, ena => ena, q => q_comp);

    cuenta_modelo: process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                modelo <= 0;
            elsif ena = '1' then
                modelo <= (modelo + 1) mod 2**N;
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
        rst <= '0'; ena <= '1'; esperar(80);
        ena <= '0'; esperar(5);
        ena <= '1'; esperar(10);
        rst <= '1'; esperar(2);
        rst <= '0'; esperar(5);

        report "tb_contador_n terminado";
        fin <= true;
        wait;
    end process;
end sim;
