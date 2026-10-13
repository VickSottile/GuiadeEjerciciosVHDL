library ieee;
use ieee.std_logic_1164.all;

entity tb_mux2x1 is
end tb_mux2x1;

architecture sim of tb_mux2x1 is
    constant N : integer := 4;
    signal sel : std_logic := '0';
    signal a0, a1, y : std_logic_vector(N-1 downto 0) := (others => '0');
begin
    uut: entity work.mux2x1
        generic map (N => N)
        port map (sel => sel, a0 => a0, a1 => a1, y => y);

    process
    begin
        a0 <= "1010";
        a1 <= "0101";

        sel <= '0';
        wait for 10 ns;
        assert y = "1010" report "con sel=0 tendria que salir a0" severity error;

        sel <= '1';
        wait for 10 ns;
        assert y = "0101" report "con sel=1 tendria que salir a1" severity error;

        -- cambio las entradas con sel fijo
        a1 <= "1111";
        wait for 10 ns;
        assert y = "1111" report "y no sigue a a1" severity error;

        sel <= '0';
        a0 <= "0001";
        wait for 10 ns;
        assert y = "0001" report "y no sigue a a0" severity error;

        report "tb_mux2x1 terminado";
        wait;
    end process;
end sim;
