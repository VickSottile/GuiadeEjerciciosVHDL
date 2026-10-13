library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- no se puede simular 12 millones de ciclos por cada digito, asi que
-- le pongo F_CLK = 4: la cuenta avanza cada 4 ciclos de reloj
entity tb_top_bcd_1seg is
end tb_top_bcd_1seg;

architecture sim of tb_top_bcd_1seg is
    constant F_CLK : integer := 4;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ena_gral : std_logic := '1';
    signal leds : std_logic_vector(3 downto 0);
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

    uut: entity work.top_bcd_1seg
        generic map (F_CLK => F_CLK)
        port map (clk => clk, rst => rst, ena_gral => ena_gral, leds => leds);

    process
        variable congelado : integer;
    begin
        rst <= '1'; ena_gral <= '1';
        wait until falling_edge(clk);
        wait until falling_edge(clk);
        rst <= '0';

        -- tras j flancos sin reset, los leds tienen que mostrar (j / F_CLK) mod 10
        for j in 1 to 12 * F_CLK loop
            wait until falling_edge(clk);
            assert to_integer(unsigned(leds)) = (j / F_CLK) mod 10
                report "leds mal en j=" & integer'image(j) &
                       ", leds=" & integer'image(to_integer(unsigned(leds)))
                severity error;
        end loop;

        -- con la habilitacion general apagada la cuenta se congela
        ena_gral <= '0';
        wait until falling_edge(clk);
        congelado := to_integer(unsigned(leds));
        for j in 1 to 3 * F_CLK loop
            wait until falling_edge(clk);
            assert to_integer(unsigned(leds)) = congelado
                report "la cuenta avanzo con ena_gral=0" severity error;
        end loop;

        report "tb_top_bcd_1seg terminado";
        fin <= true;
        wait;
    end process;
end sim;
