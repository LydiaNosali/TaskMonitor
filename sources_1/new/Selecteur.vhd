----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:47:09
-- Design Name: 
-- Module Name: Selecteur - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Selecteur is
  Port ( 
      reset : in std_logic;
      cid : in std_logic_vector(4 downto 0);
      dec_cid : out std_logic_vector(19 downto 0)
  );
end Selecteur;

architecture Behavioral of Selecteur is

begin
process(cid)
begin
    if reset='1' then
        dec_cid <= ( others =>'1');
    else
        dec_cid <= ( others =>'0');
        dec_cid (conv_integer(cid)) <= '1';
    end if;
end process;

end Behavioral;
