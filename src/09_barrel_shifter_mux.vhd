library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter_mux is
    generic (
        N : integer := 8;
        M : integer := 3
    );
    port (
        a   : in  std_logic_vector(N-1 downto 0);
        des : in  std_logic_vector(M-1 downto 0);
        s   : out std_logic_vector(N-1 downto 0)
    );
end barrel_shifter_mux;

-- M etapas de muxes 2x1. La etapa i desplaza 2^i posiciones si des(i)='1'
-- y si no deja el dato como esta. Asi se arma cualquier desplazamiento de 0 a N-1.
architecture estructural of barrel_shifter_mux is
    type t_etapas  is array (0 to M)   of std_logic_vector(N-1 downto 0);
    type t_desplaz is array (0 to M-1) of std_logic_vector(N-1 downto 0);
    signal etapa : t_etapas;
    signal despl : t_desplaz;
begin
    assert 2**M = N report "barrel_shifter_mux: tiene que ser 2^M = N" severity failure;

    etapa(0) <= a;

    gen_etapas: for i in 0 to M-1 generate
        -- el dato corrido 2^i lugares (solo cableado), lo que sobra se rellena con 0
        gen_bits: for j in 0 to N-1 generate
            con_dato: if j + 2**i < N generate
                despl(i)(j) <= etapa(i)(j + 2**i);
            end generate;
            con_cero: if j + 2**i >= N generate
                despl(i)(j) <= '0';
            end generate;
        end generate;

        mux_i: entity work.mux2x1
            generic map (N => N)
            port map (sel => des(i), a0 => etapa(i), a1 => despl(i), y => etapa(i+1));
    end generate;

    s <= etapa(M);
end estructural;
