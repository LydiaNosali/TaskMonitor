library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package types is
	type wcet_table     is array (natural range<>) of std_logic_vector(15 downto 0); 
	type cmd_table      is array (natural range<>) of std_logic_vector(2 downto 0);
	type states         is (idle, ready, running, suspended, overrun);
    type states_table   is array (natural range<>) of states;	
end types;
