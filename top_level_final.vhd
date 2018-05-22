----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2018 12:05:14 AM
-- Design Name: 
-- Module Name: top_level_final - Behavioral
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

entity top_level_final is
    Port ( Preset_Value : in STD_LOGIC_VECTOR (9 downto 0);
           Sel : in STD_LOGIC;
           Operation : in STD_LOGIC_VECTOR (1 downto 0);
           UART_rtl_rxd : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PRESET : in STD_LOGIC;
           Count_Direction : in STD_LOGIC;
           count : in STD_LOGIC;
           GPIO_Out : out STD_LOGIC_VECTOR (15 downto 0);
           UART_rtl_txd : out STD_LOGIC;
           SSD_Value : out STD_LOGIC_VECTOR (6 downto 0);
           SSD_Select : out STD_LOGIC_VECTOR (3 downto 0));
end top_level_final;

architecture Behavioral of top_level_final is

component demux
Port ( input : in STD_LOGIC_VECTOR (9 downto 0);
           sel : in STD_LOGIC;
           output0 : out STD_LOGIC_VECTOR (9 downto 0);
           output1 : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component counter
Port ( PREVal : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           PRESET : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CD : in STD_LOGIC;
           Count_Out : out STD_LOGIC_VECTOR (9 downto 0);
           TC : in STD_LOGIC);
 end component;
 
 component top_level_ssd
 Port ( clk : in STD_LOGIC;
            input : in STD_LOGIC_VECTOR (9 downto 0);
            seg_select : out STD_LOGIC_VECTOR (3 downto 0);
            seven_seg_out : out STD_LOGIC_VECTOR (6 downto 0));
 end component;

component design_1_wrapper
 port (
   clk_100MHz : in STD_LOGIC;
   gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
   gpio_rtl_1_tri_i : in STD_LOGIC_VECTOR ( 21 downto 0 );
   reset_rtl_0 : in STD_LOGIC;
   uart_rtl_0_rxd : in STD_LOGIC;
   uart_rtl_0_txd : out STD_LOGIC
 );
 end component;
 
 component debouncer 
     Port ( clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            input : in STD_LOGIC;
            output : out STD_LOGIC);
 end component;
 
signal in1 : STD_LOGIC_VECTOR (9 downto 0);
signal in2 : STD_LOGIC_VECTOR (9 downto 0);
signal c_out : STD_LOGIC_VECTOR (9 downto 0);
signal cl : STD_LOGIC := not CLK;
signal gpio : STD_LOGIC_VECTOR ( 21 downto 0 ) := in2&Operation&c_out;
signal dbCount: STD_LOGIC;
begin

u0: debouncer port map(
          clk=>cl,
          reset=> RESET,
          input=>count,
          output=>dbCount
          );

u1: demux port map(
           input => Preset_Value,
           sel => Sel ,
           output0 => in1,
           output1 => in2
 );
 
 u2: counter port map(
           PREVal => in1,
            CLK => cl,
            PRESET => PRESET,
            RESET => RESET,
            CD => Count_Direction,
            Count_Out =>c_out,
            TC => dbCount
  );

u3: top_level_ssd port map(
            clk => cl,
            input => c_out,
            seg_select => SSD_Select,
            seven_seg_out => SSD_Value
  );
  
u4: design_1_wrapper port map(
 clk_100MHz => cl,
   gpio_rtl_0_tri_o => GPIO_Out,
   gpio_rtl_1_tri_i => gpio,
   reset_rtl_0 => RESET,
   uart_rtl_0_rxd => UART_rtl_rxd,
   uart_rtl_0_txd => UART_rtl_txd
   );
 
 
end Behavioral;
