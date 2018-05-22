----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2018 11:12:38 PM
-- Design Name: 
-- Module Name: demux - Behavioral
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

entity demux is
    Port ( input : in STD_LOGIC_VECTOR (9 downto 0);
           sel : in STD_LOGIC;
           output0 : out STD_LOGIC_VECTOR (9 downto 0);
           output1 : out STD_LOGIC_VECTOR (9 downto 0));
end demux;

architecture Behavioral of demux is

begin

output0 <=input when sel='0' else "0000000000";
output1 <= input when sel='1' else "0000000000";



end Behavioral;
