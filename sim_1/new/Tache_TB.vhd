----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2021 00:02:03
-- Design Name: 
-- Module Name: Tache_TB - Behavioral
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

entity Tache_TB is
--  Port ( );
end Tache_TB;

architecture Behavioral of Tache_TB is

    signal clk_img    : std_logic := '0';
    signal reset_img  : std_logic := '0';
    signal wcet_img   : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(10, 16));  
    signal cmd_img    : std_logic_vector(2 downto 0);
    signal enable_img : std_logic := '1';
    signal state_in_img : states;
    signal state_out_img  : states;
    signal irq_img    : std_logic;

begin
tache1: entity work.Tache(Behavioral) port map (
       clk         => clk_img,
       reset       => reset_img,
       wcet        => wcet_img,
       cmd         => cmd_img,
       enable      => enable_img,
       state_in    => state_in_img,
       state_out   => state_out_img,
       irq         => irq_img
   );

process
begin
    cmd_img <= "011"; --load
    state_in_img <= state_out_img;
    wait for 100 ps;
    state_in_img <= state_out_img;
    cmd_img <= "010"; --start
    wait for 100 ps;
    state_in_img <= state_out_img;
    cmd_img <= "100"; --suspend
    wait for 100 ps;
    state_in_img <= state_out_img;
    cmd_img <= "101"; --resume
    wait for 100 ps;
    state_in_img <= state_out_img;
    cmd_img <= "110"; --stop
    wait for 100 ps;
end process;


--l'horloge
process
begin
    clk_img <= not clk_img;
    wait for 5 ps;
end process;

process 
begin
    enable_img <= '0';
    wait for 300 ns;
    enable_img <= '1';
    wait for 300 ns;
end process;

process
begin
    reset_img <= '1';
    wait for 1 ps;
    reset_img <= '0';
    wait for 300 ns;
end process;
end Behavioral;
