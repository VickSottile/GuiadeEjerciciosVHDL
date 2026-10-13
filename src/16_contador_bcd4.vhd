library ieee;
use ieee.std_logic_1164.all;

entity contador_bcd4 is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        ena  : in  std_logic;
        bcd3 : out std_logic_vector(3 downto 0);
        bcd2 : out std_logic_vector(3 downto 0);
        bcd1 : out std_logic_vector(3 downto 0);
        bcd0 : out std_logic_vector(3 downto 0);
        co   : out std_logic    -- pasa a 1 cuando el contador esta en 9999 y esta habilitado
    );
end contador_bcd4;

-- 4 contadores BCD en cadena: cada digito cuenta solo si todos los de abajo estan en 9
architecture estructural of contador_bcd4 is
    type t_bcd is array (0 to 3) of std_logic_vector(3 downto 0);
    signal qd    : t_bcd;
    signal ena_d : std_logic_vector(3 downto 0);
    signal co_d  : std_logic_vector(3 downto 0);
begin
    ena_d(0) <= ena;
    ena_d(1) <= ena_d(0) and co_d(0);
    ena_d(2) <= ena_d(1) and co_d(1);
    ena_d(3) <= ena_d(2) and co_d(2);

    gen_dig: for i in 0 to 3 generate
        dig_i: entity work.contador_bcd_est
            port map (clk => clk, rst => rst, ena => ena_d(i), q => qd(i), co => co_d(i));
    end generate;

    bcd0 <= qd(0);
    bcd1 <= qd(1);
    bcd2 <= qd(2);
    bcd3 <= qd(3);
    co   <= ena_d(3) and co_d(3);
end estructural;
