library ieee;
use ieee.std_logic_1164.all;

entity contador_n_est is
    generic (N : integer := 4);
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        q   : out std_logic_vector(N-1 downto 0)
    );
end contador_n_est;

-- igual que el de 4 bits pero con generate
architecture estructural of contador_n_est is
    signal qi : std_logic_vector(N-1 downto 0);
    signal d  : std_logic_vector(N-1 downto 0);
    signal t  : std_logic_vector(N downto 0);   -- t(i) = ena y todos los bits menores a i en 1
begin
    t(0) <= ena;

    gen_ff: for i in 0 to N-1 generate
        t(i+1) <= t(i) and qi(i);
        d(i)   <= qi(i) xor t(i);

        ff_i: entity work.ffd
            port map (clk => clk, rst => rst, ena => '1', d => d(i), q => qi(i));
    end generate;

    q <= qi;
end estructural;
