library ieee;
use ieee.std_logic_1164.all;

entity contador_bcd_est is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        q   : out std_logic_vector(3 downto 0);
        co  : out std_logic    -- en 1 cuando la cuenta esta en 9
    );
end contador_bcd_est;

architecture estructural of contador_bcd_est is
    constant nueve : std_logic_vector(3 downto 0) := "1001";

    signal qi      : std_logic_vector(3 downto 0);
    signal mas_uno : std_logic_vector(3 downto 0);
    signal d       : std_logic_vector(3 downto 0);
    signal es_nueve : std_logic;
    signal rst_reg  : std_logic;
begin
    inc: entity work.incrementador4
        port map (a => qi, y => mas_uno);

    -- si ena=0 el registro se realimenta con su propio valor
    mux: entity work.mux2x1
        generic map (N => 4)
        port map (sel => ena, a0 => qi, a1 => mas_uno, y => d);

    cmp: entity work.comparador
        generic map (N => 4)
        port map (a => qi, b => nueve, igual => es_nueve);

    -- al llegar a 9 y contar, el siguiente flanco resetea el registro (vuelve a 0)
    rst_reg <= rst or (es_nueve and ena);

    reg: entity work.registro_n
        generic map (N => 4)
        port map (clk => clk, rst => rst_reg, d => d, q => qi);

    q  <= qi;
    co <= es_nueve;
end estructural;
