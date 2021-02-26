----------------------------------------------------------------------------------
-- Company:        ITESM - Campus Qro.
-- Engineer:       José Pablo Miranda Berumen
-- 
-- Create Date:    13:36:34 02/22/2021 
-- Design Name: 
-- Module Name:    freqdiv - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:    Tail light signal and hazard control as a sequence
--                 See video: https://www.youtube.com/watch?v=jIjY7mERBrw
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: Checar diagramas en Documents/.../Mustang Tail Lights
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity FreqDiv is
  port (
     Clk   : in  STD_LOGIC;
	  Rst   : in  STD_LOGIC;
	  ClkEn : out STD_LOGIC);
end FreqDiv;

architecture rtl of FreqDiv is
  -- Signal and constants used by the Frequency Divider
  -- Embedded signals declaration
  -- Used by Frequency Divider (FreqDiv)

  -- Define a value that contains the desired Frequency
  constant DesiredFreq : natural := 2;  -- Once per second changes in the FSM
  -- Frequency for a DE2-Lite board is 50MHz
  constant BoardFreq   : natural := 50_000_000;
  -- Calculate the value the counter should reach to obtain desired Freq.
  constant MaxOscCount : natural := BoardFreq / DesiredFreq;
  -- Pulse counter for the oscillator
  signal OscCount      : natural range 0 to MaxOscCount;  

  begin
    Freq_Div: process(Rst,Clk)
	 begin
	   if (Rst = '0') then
        OscCount <= 0;
		elsif rising_edge(Clk) then
        if (OscCount = 	MaxOscCount) then
		     ClkEn    <= '1';
			  OscCount <= 0;
		  else
		     ClkEn    <= '0';
			  OscCount <= OscCount + 1;
		  end if;
		end if;
	 end process Freq_Div;
	 
end rtl;
