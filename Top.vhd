----------------------------------------------------------------------------------
-- Company:        ITESM - CQ        
-- Engineer:       José Pablo Miranda Berumen A01706702
-- 
-- Create Date:    10:18 pm 24/02/2021 
-- Design Name: 
-- Module Name:     
-- Project Name: 	 Top (Unidad de Control)
-- Target Devices: 
-- Tool versions:  Quartus lite 18.1
-- Description:    Desarrollo de una Unidad de control para CPU
--                 
--                 
--                 
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
-- Commonly uses libraries and packages
Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

Entity Top is
    Port ( Rst   		: in  STD_LOGIC;
           Clk   		: in  STD_LOGIC;
           Dato  		: in  STD_LOGIC;
			  OffLEDs 	: OUT STD_LOGIC_VECTOR(3 downto 0);
           Pulso 		: out STD_LOGIC_VECTOR (5 downto 0));
End Top;

Architecture Top_Arch of Top is

-- Component Declaration --
	  	
	-- Frequency divider for clk inputs
	
	component FreqDiv
	  port (
		  Clk   : in  STD_LOGIC;
		  Rst   : in  STD_LOGIC;
		  ClkEn : out STD_LOGIC);
	end component;
	
	-- Finate State Machine for Control Unit
	
	component FSM_CU
	  port (
		  Clk   : in  STD_LOGIC;
		  Rst   : in  STD_LOGIC;
		  ClkEn : in  STD_LOGIC;
		  Dato  : in  STD_LOGIC;
		  Pulso : out STD_LOGIC_VECTOR (5 downto 0));
   end component;
	
--	-- Debounce
--	Component Debounce
--    Port(
--      clk     : in  STD_LOGIC;  --input clock
--      reset   : in  STD_LOGIC;  --asynchronous active high reset
--      button  : in  STD_LOGIC;  --input signal to be debounced
--      result  : out STD_LOGIC); --debounced signal
--  End component;
  
  -- Embedded Signals
	signal ClkEn_emb : STD_LOGIC;
	
	
Begin
	-- Instantiation of components
  U1 : FreqDiv
	port map (
		Clk   => Clk,
		Rst   => Rst,
		ClkEn => ClkEn_emb);
	
	
  U2 : FSM_CU
	port map (
		Clk    => Clk,
		Rst    => Rst,
		ClkEn  => ClkEn_emb,
		Dato => Dato,
		Pulso => Pulso);
		
	
--	U3	:	Debounce
--	Port Map (
--		clk	 => Clk,
--		reset  => Rst,
--		button => Load,
--		result => emb_load);


-- Turn unused LEDs Off
   OffLEDs <= "0000";

 End Top_Arch;
