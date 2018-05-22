----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2018 10:41:04 PM
-- Design Name: 
-- Module Name: bin_2_bcd - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_2_bcd is
    Port ( binary_in : in STD_LOGIC_VECTOR (9 downto 0);
           bcd_out : out STD_LOGIC_VECTOR (15 downto 0));
end bin_2_bcd;

architecture Behavioral of bin_2_bcd is

begin

   bin_to_bcd : process (binary_in)
      -- Internal variable for storing bits
      variable shift : unsigned(25 downto 0);
      
	  -- Alias for parts of shift register
      alias num is shift(9 downto 0);
      alias one is shift(13 downto 10);
      alias ten is shift(17 downto 14);
      alias hun is shift(21 downto 18);
      alias th is shift(25 downto 22);
   begin
      -- Clear previous number and store new number in shift register
      num := unsigned(binary_in);
      one := X"0";
      ten := X"0";
      hun := X"0";
      th := X"0";
      
	  -- Loop eight times
      for i in 1 to num'Length loop
	     -- Check if any digit is greater than or equal to 5
         if one >= 5 then
            one := one + 3;
         end if;
         
         if ten >= 5 then
            ten := ten + 3;
         end if;
         
         if hun >= 5 then
            hun := hun + 3;
         end if;
         
         if th >= 5 then
                     th := th + 3;
                  end if;         
		 -- Shift entire register left once
         shift := shift_left(shift, 1);
      end loop;
      
	  -- Push decimal numbers to output
      bcd_out <= std_logic_vector(th)&std_logic_vector(hun)&std_logic_vector(ten)&std_logic_vector(one);

   end process;

end Behavioral;








