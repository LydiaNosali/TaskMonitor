----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:58:46
-- Design Name: 
-- Module Name: Selecteur_TB - Behavioral
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

entity Selecteur_TB is
--  Port ( );
end Selecteur_TB;

architecture Behavioral of Selecteur_TB is

signal reset_img : std_logic := '0';
signal cid_img : std_logic_vector(4 downto 0);
signal dec_cid_img : std_logic_vector(19 downto 0);

component Selecteur is
  Port ( 
      reset : in std_logic;
      cid : in std_logic_vector(4 downto 0);
      dec_cid : out std_logic_vector(19 downto 0)
  );
end component;
begin
selecteur1 : Selecteur port map(reset => reset_img, cid => cid_img, dec_cid => dec_cid_img);

process
begin
    cid_img <= "00001";
    wait for 10 ps;
    cid_img <= "00010";
    wait for 10 ps;
    
end process;
process
begin
    reset_img <= not reset_img;
    wait for 10 ps;
end process;
end Behavioral;
