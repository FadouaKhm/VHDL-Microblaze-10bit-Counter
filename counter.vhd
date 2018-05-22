---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2018 12:34:51 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
  Port ( PREVal : in STD_LOGIC_VECTOR (9 downto 0);
         CLK : in STD_LOGIC;
         PRESET : in STD_LOGIC;
         RESET : in STD_LOGIC;
         CD : in STD_LOGIC;
         Count_Out : out STD_LOGIC_VECTOR (9 downto 0);
         TC : in STD_LOGIC);
end counter;

architecture Behavioral of counter is
signal count : std_logic_vector(9 downto 0):=(others =>'0');
begin
process(CLK, PRESET, TC)
begin
if RESET='1'  then 
  count<=(others =>'0');
elsif (rising_edge(CLK) and TC='1' ) then
     
     if PRESET='1' then
          if (PREVal <= "1111101000") then
          count<=PREVal;
          else
          count<="1111101000";
          end if;
      else 
         if CD='0' then
           if (count= "1111101000") then
           count<=(others =>'0');
           else
         count<=count+1;
           end if;
         else
           if (count= "0000000000") then
            count<="1111101000";
            else
            count<=count-1;
            end if;
         end if;     
      end if;
end if;
end process;

COUNT_OUT<=count;

end Behavioral;