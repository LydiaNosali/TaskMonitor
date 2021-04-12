----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:44:47
-- Design Name: 
-- Module Name: Moniteur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.Types.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Moniteur is
      generic (
        N : in std_logic_vector(4 downto 0) := "10100"
      ); 
      Port (
        clk, reset : in std_logic;
        cmd : in std_logic_vector(2 downto 0);
        cid : in std_logic_vector(4 downto 0);
        wcet : in std_logic_vector(15 downto 0); -- us
        irq : out std_logic;
        -- pour le testbench
        t_state_out : out states_table(19 downto 0);
        t_irq       : out std_logic_vector(19 downto 0);
        t_dec_cid   : out std_logic_vector(19 downto 0);
        t_clk_out   : out std_logic
      );
end Moniteur;

architecture Behavioral of Moniteur is
    --taches
    signal clk_img          : std_logic := '0';
    signal wcet_img         : wcet_table(19 downto 0) := (others => std_logic_vector(to_unsigned(0, 16)));  
    signal cmd_img          : cmd_table(19 downto 0)  := (others => "000");
    signal state_in_img     : states_table(19 downto 0) := (others => idle);
    signal state_out_img    : states_table(19 downto 0);
    signal irq_img          : std_logic_vector(19 downto 0) := (others => '0');
    signal dec_cid_img      : std_logic_vector(19 downto 0) := (others => '0');
    --div_freq
    signal clk_out_img      : std_logic;
    
    component Tache is
        Port ( 
            clk, reset : in std_logic; 
            wcet : in std_logic_vector(15 downto 0); --worst execution time
            cmd : in std_logic_vector(2 downto 0); --commande
            enable : in std_logic; --signal de selection de la tache
            state_in : in states; -- l'état en entrée
            state_out : out states; -- l'état en sortie
            irq : out std_logic -- le signal d'interruption
        );
    end component;

begin
div_freq1 : entity work.Div_Freq generic map(4) port map(clk_in => clk, clk_out => clk_out_img);
selecteur1 : entity work.Selecteur port map(reset => reset, cid => cid, dec_cid => dec_cid_img);

generate_tache : for i in 0 to (conv_integer(N-1)) generate
    tache_i : Tache port map (
           clk         => clk_out_img,
           reset       => reset,
           wcet        => wcet_img(i),
           cmd         => cmd_img(i),
           enable      => dec_cid_img(i),
           state_in    => state_in_img(i),
           state_out   => state_out_img(i),
           irq         => irq_img(i)
       );
       end generate generate_tache;


process(clk_out_img) 
begin
    if clk_out_img'event and clk_out_img='1' then
        wcet_img(conv_integer(cid)) <= wcet;
        cmd_img(conv_integer(cid))  <= cmd;
    end if;
end process;
       
process(clk_out_img, irq_img)
begin
    if reset = '1' then 
        irq     <= '0'; 
    elsif 
        clk_out_img'event and clk_out_img='1' then 
            for i in 0 to (conv_integer(N-1)) loop 
                if irq_img(i)='1' then
                    irq <='1'; 
                end if; 
            end loop; 
     end if;
end process;

update_state: process(clk)
    begin
    if clk'event and clk = '0' then
        state_in_img <= state_out_img ;
    end if;
end process;

process(clk_out_img)
begin
    t_clk_out       <= clk_out_img;
    t_dec_cid       <= dec_cid_img;
    t_state_out     <= state_out_img;
    t_irq           <= irq_img;
end process;
end Behavioral;
