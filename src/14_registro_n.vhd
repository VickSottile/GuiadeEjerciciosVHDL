library ieee;
use ieee.std_logic_1164.all;

entity registro_n is
    generic (N : integer := 4);
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        d   : in  std_logic_vector(N-1 downto 0);
        q   : out std_logic_vector(N-1 downto 0)
    );
end registro_n;

-- N flip-flops del ejercicio 5, con la habilitacion siempre en 1
architecture estructural of registro_n is
begin
    gen_ff: for i in 0 to N-1 generate
        ff_i: entity work.ffd
            port map (clk => clk, rst => rst, ena => '1', d => d(i), q => q(i));
    end generate;
end estructural;
