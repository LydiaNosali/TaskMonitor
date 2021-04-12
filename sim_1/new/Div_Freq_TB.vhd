----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:51:11
-- Design Name: 
-- Module Name: Div_Freq_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Div_Freq_TB is
--  Port ( );
end Div_Freq_TB;

architecture Behavioral of Div_Freq_TB is

signal clk_in_img : std_logic := '0';
signal clk_out_img : std_logic;

component Div_Freq is
       generic (
           div_value : integer
       );
       Port ( clk_in : in STD_LOGIC;
              clk_out : out STD_LOGIC);
end component;

begin
div_freq1 : Div_Freq generic map(4) port map(clk_in => clk_in_img, clk_out => clk_out_img);

process
begin
    clk_in_img <= not clk_in_img;
    wait for 5 ps;
end process;

end Behavioral;
