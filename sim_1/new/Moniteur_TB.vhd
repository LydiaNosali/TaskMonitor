----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2021 09:30:21
-- Design Name: 
-- Module Name: Moniteur_TB - Behavioral
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
use WORK.TYPES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity Moniteur_TB is
--  Port ( );
end Moniteur_TB;

architecture Behavioral of Moniteur_TB is

signal cmd_img      : std_logic_vector(2 downto 0) := "011";
signal cid_img      : std_logic_vector(4 downto 0) := "00001";
signal wcet_img     : std_logic_vector(15 downto 0) := x"000a";
signal irq_img      : std_logic;
signal clk_img      : std_logic := '0';
signal reset_img    : std_logic;
signal t_state_out  : states_table(19 downto 0);
signal t_irq        : std_logic_vector(19 downto 0);
signal t_dec_cid    : std_logic_vector(19 downto 0);
signal clk_out_img  : std_logic;

begin
moniteur1 : entity work.Moniteur generic map(N => "10100") 
            port map(
                clk => clk_img, 
                reset => reset_img, 
                cmd =>cmd_img, 
                cid => cid_img, 
                wcet => wcet_img, 
                irq => irq_img,
                t_state_out => t_state_out,
                t_irq => t_irq,
                t_dec_cid  => t_dec_cid,
                t_clk_out => clk_out_img
            );
            
--l'horloge
horloge: process
begin
    clk_img <= not clk_img;
    wait for 5 ps;
end process;

reset: process
begin
    reset_img <= '1';
    wait for 1 ps;
    reset_img <= '0';
    wait for 300 ns;
end process;

test: process
begin
    wait for 50 ps;
    cmd_img <= "010"; --start
    wait for 400 ps;
end process;

end Behavioral;
