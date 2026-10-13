library ieee;
use ieee.std_logic_1164.all;

entity top_bcd_1seg is
    generic (F_CLK : integer := 125_000_000);   -- clock de la Arty Z7 (125 MHz)
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        ena_gral : in  std_logic;   -- un switch
        leds     : out std_logic_vector(3 downto 0)
    );
end top_bcd_1seg;

architecture estructural of top_bcd_1seg is
    signal ena_1seg : std_logic;
begin
    -- un pulso por segundo = un pulso cada F_CLK ciclos
    base_tiempo: entity work.gen_ena
        generic map (N => F_CLK)
        port map (clk => clk, rst => rst, ena => ena_gral, s => ena_1seg);

    contador: entity work.contador_bcd_est
        port map (clk => clk, rst => rst, ena => ena_1seg, q => leds, co => open);
end estructural;
