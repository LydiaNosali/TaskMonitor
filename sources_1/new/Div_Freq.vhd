----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:46:11
-- Design Name: 
-- Module Name: Div_Freq - Behavioral
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

entity Div_Freq is
       generic (
           div_value : integer
       );
       Port ( clk_in : in STD_LOGIC;
              clk_out : out STD_LOGIC);
end Div_Freq;

architecture Behavioral of Div_Freq is

signal cpt : integer := 1;
signal clkimg : std_logic := '0';

begin
process(clk_in)
begin
    if clk_in'event and clk_in = '1' then
        cpt <= cpt +1;
        if cpt = div_value then
            cpt <= 1;
            clkimg <= not clkimg;
         end if;
     end if;
     clk_out <= clkimg;
end process;
end Behavioral;
