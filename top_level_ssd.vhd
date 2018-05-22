----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2018 02:38:35 PM
-- Design Name: 
-- Module Name: top_level_ssd - Behavioral
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

entity top_level_ssd is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (9 downto 0);
           seg_select : out STD_LOGIC_VECTOR (3 downto 0);
           seven_seg_out : out STD_LOGIC_VECTOR (6 downto 0));
end top_level_ssd;

architecture Behavioral of top_level_ssd is
 component bin_2_bcd
    Port (
               binary_in : in STD_LOGIC_VECTOR (9 downto 0);
               bcd_out : out STD_LOGIC_VECTOR (15 downto 0));
 end component;

component seven_segment_display_VHDL
   Port ( clock_100Mhz : in STD_LOGIC;
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0);
           displayed_number : in STD_LOGIC_VECTOR (15 downto 0));
 end component;
 
 signal io : STD_LOGIC_VECTOR (15 downto 0);
begin 

u1: bin_2_bcd port map(
 binary_in => input,
 bcd_out => io
 );
 
 u2: seven_segment_display_VHDL port map(
           clock_100Mhz => clk,
            Anode_Activate => seg_select,
            LED_out => seven_seg_out,
            displayed_number => io
  );
 

end Behavioral;
