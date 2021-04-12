----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2021 22:45:43
-- Design Name: 
-- Module Name: Tache - Behavioral
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

entity Tache is
    Port ( 
        clk, reset : in std_logic; 
        wcet : in std_logic_vector(15 downto 0); --worst execution time
        cmd : in std_logic_vector(2 downto 0); --commande
        enable : in std_logic; --signal de selection de la tache
        state_in : in states; -- l'état en entrée
        state_out : out states; -- l'état en sortie
        irq : out std_logic -- le signal d'interruption
    );
end Tache;

architecture Behavioral of Tache is

signal wcet_img : std_logic_vector(15 downto 0);-- us

begin

process (clk, reset)
begin
    if reset = '1' then
        wcet_img <= wcet;
        state_out <= idle;
        irq <= '0';
    elsif enable ='1' and state_in /= overrun and clk'event and clk='1' then
        case state_in is
            when idle => if cmd="011" then --load
                            state_out <= ready;
                         end if;
            when ready => if cmd="010" then --start
                             state_out <= running;
                          end if;
            when running => if cmd="110" then --stop
                               state_out <= idle;
                               irq <= '0';
                            elsif cmd = "100" then--suspend
                               state_out <= suspended;
                            end if;
                            wcet_img <= wcet_img - 1;
                            if wcet_img <= 0 then
                                irq <= '1';
                                state_out <= overrun;--overrun
                            end if;
             when suspended => if cmd="101" then--resume
                                  state_out <= running;
                               end if;
             when others => state_out <= idle;
        end case;
    end if;
end process;

end Behavioral;
